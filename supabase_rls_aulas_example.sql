-- Run this in Supabase → SQL Editor if Row Level Security blocks reads from `public.aulas`.
-- Adjust roles/policies to match your product (public vs authenticated-only).

alter table public.aulas enable row level security;

-- Logged-in users can list all classes
create policy "aulas_select_authenticated"
  on public.aulas
  for select
  to authenticated
  using (true);

-- Optional: allow reads without login (e.g. marketing app)
-- create policy "aulas_select_anon"
--   on public.aulas
--   for select
--   to anon
--   using (true);
