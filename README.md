# Portal del Funcionario — Deploy en GitHub + Netlify

## Contenido
- `index.html` (portada)
- `login.html` (acceso con Supabase)
- `carrera.html` (resumen personal con cálculos)
- `admin.html` (panel RRHH con upsert a `funcionarios`)
- `calidad.html`
- `vehiculos.html` y `insumos.html` (registros con Supabase + “Mis solicitudes”)
- `supabase_schema.sql` (tablas + RLS)
- `_redirects`, `netlify.toml`
- `Calificaciones.png` (logo)

## Pasos
1. **Supabase**
   - Crea proyecto y copia `URL` y `anon key`.
   - En el panel SQL, ejecuta `supabase_schema.sql`.
   - Agrega correos en tabla `admins`.
   - En Auth → URL Configuration: agrega `https://<tu-sitio>.netlify.app` en Site URL y Redirect URLs.

2. **Reemplaza credenciales** en `login.html`, `carrera.html`, `admin.html`, `vehiculos.html`, `insumos.html`:
   ```js
   const SUPABASE_URL = 'https://TU-PROYECTO.supabase.co';
   const SUPABASE_ANON_KEY = 'TU-ANON-KEY';
   ```

3. **GitHub**
   ```bash
   git init
   git add .
   git commit -m "Portal del Funcionario"
   git branch -M main
   git remote add origin https://github.com/<tu-usuario>/<tu-repo>.git
   git push -u origin main
   ```

4. **Netlify**
   - Add new site → Import from Git → selecciona tu repo.
   - Build command: *vacío* | Publish directory: `./`.
   - (Opcional) Conecta dominio propio.

> Seguridad: el `anon key` es público por diseño en apps cliente. La protección real es **RLS** en Supabase (incluida en `supabase_schema.sql`).

