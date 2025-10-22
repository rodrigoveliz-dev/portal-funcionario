# Portal del Funcionario — Soporte para Envío Anónimo (Sin Login)

Este paquete agrega la posibilidad de enviar formularios de **solicitudes de vehículos** e **insumos**
sin requerir inicio de sesión en Supabase, manteniendo la seguridad de los datos mediante
Row Level Security (RLS).

## Archivos incluidos

- `supabase_patch_anon_submit.sql` → Ejecuta este script en tu Supabase (SQL Editor) para habilitar inserciones anónimas.
- Ajustes recomendados en `vehiculos.html` e `insumos.html`:
  - Agregar campo `correo_contacto` al formulario.
  - Modificar la función `save()` para insertar con `email = null` y `contacto_email` si el usuario no está logeado.

## Pasos de implementación

1. Entra a Supabase → SQL Editor → `New Query`
2. Pega el contenido del archivo `supabase_patch_anon_submit.sql`
3. Ejecuta con el botón ▶️ Run
4. Confirma que las políticas y columnas se aplicaron correctamente.
5. Vuelve a subir los archivos HTML modificados a tu repositorio de GitHub.
6. Netlify redeployará automáticamente tu portal.

Una vez aplicado, los visitantes podrán enviar formularios sin iniciar sesión.
Sus solicitudes se almacenarán con `email = null` y `contacto_email` con el correo de contacto ingresado.

