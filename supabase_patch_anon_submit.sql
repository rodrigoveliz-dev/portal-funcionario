-- PATCH: Permitir enviar solicitudes SIN login (anon) a Supabase

-- 1) Ajustar tablas para invitados (email puede ser NULL y se agrega contacto_email)
alter table public.solicitudes_vehiculos
  alter column email drop not null;
alter table public.solicitudes_vehiculos
  add column if not exists contacto_email text;

alter table public.solicitudes_insumos
  alter column email drop not null;
alter table public.solicitudes_insumos
  add column if not exists contacto_email text;

-- 2) Políticas RLS: permitir INSERT para rol anónimo, sin otorgar lectura
create policy anon_insert_vehiculos on public.solicitudes_vehiculos
  for insert
  with check (auth.role() = 'anon');

create policy anon_insert_insumos on public.solicitudes_insumos
  for insert
  with check (auth.role() = 'anon');

-- Notas:
-- - Las políticas de SELECT existentes siguen restringiendo la lectura por email o admin.
-- - Invitados NO podrán listar ni ver solicitudes; solo enviar (INSERT).
