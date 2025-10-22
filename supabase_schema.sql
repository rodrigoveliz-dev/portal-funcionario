-- SUPABASE DDL + RLS para Portal del Funcionario
create extension if not exists pgcrypto;

-- Administradores
create table if not exists public.admins(
  email text primary key
);
alter table public.admins enable row level security;

-- Funcionarios (fuente de verdad para carrera.html)
create table if not exists public.funcionarios(
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  email text unique not null,
  categoria text, -- A-F
  fecha_inicio_contrato date,
  tipo_contrato text,
  fecha_ingreso_publico date,
  cap_totales int,
  cap_encasillados int,
  cap_totales_corte int,
  fecha_ultimo_corte date
);
alter table public.funcionarios enable row level security;

-- Solicitudes Vehículos
create table if not exists public.solicitudes_vehiculos(
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  email text not null,
  unidad text,
  solicitante text,
  telefono text,
  fecha date,
  horario text,
  origen text,
  destino text,
  pasajeros int,
  conductor text,
  prioridad text,
  motivo text,
  estado text default 'Pendiente'
);
alter table public.solicitudes_vehiculos enable row level security;

-- Solicitudes Insumos
create table if not exists public.solicitudes_insumos(
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  email text not null,
  dependencia text,
  solicitante text,
  telefono text,
  insumo text,
  cantidad int,
  prioridad text,
  descripcion text,
  centro text,
  enlace text,
  estado text default 'Pendiente'
);
alter table public.solicitudes_insumos enable row level security;

-- Policies: usuarios ven/insertan solo lo suyo
create policy if not exists usuario_funcionario_select on public.funcionarios
  for select using (auth.email() = email);
create policy if not exists admin_funcionario_select on public.funcionarios
  for select using (exists(select 1 from public.admins a where a.email = auth.email()));
create policy if not exists admin_funcionario_upsert on public.funcionarios
  for insert with check (exists(select 1 from public.admins a where a.email = auth.email()));
create policy if not exists admin_funcionario_update on public.funcionarios
  for update using (exists(select 1 from public.admins a where a.email = auth.email()));

create policy if not exists usuario_ve_y_crea_sus_vehiculos on public.solicitudes_vehiculos
  for select using (auth.email() = email);
create policy if not exists usuario_inserta_vehiculos on public.solicitudes_vehiculos
  for insert with check (auth.email() = email);
create policy if not exists admin_vehiculos_full on public.solicitudes_vehiculos
  for select using (exists(select 1 from public.admins a where a.email = auth.email()));
create policy if not exists admin_vehiculos_update on public.solicitudes_vehiculos
  for update using (exists(select 1 from public.admins a where a.email = auth.email()));

create policy if not exists usuario_ve_y_crea_sus_insumos on public.solicitudes_insumos
  for select using (auth.email() = email);
create policy if not exists usuario_inserta_insumos on public.solicitudes_insumos
  for insert with check (auth.email() = email);
create policy if not exists admin_insumos_full on public.solicitudes_insumos
  for select using (exists(select 1 from public.admins a where a.email = auth.email()));
create policy if not exists admin_insumos_update on public.solicitudes_insumos
  for update using (exists(select 1 from public.admins a where a.email = auth.email()));
