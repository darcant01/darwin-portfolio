-- Supabase setup for the portfolio contact form
-- Run this in: Supabase Dashboard → SQL Editor → New query → paste → Run

create table if not exists public.inquiries (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  email text not null,
  service text,
  message text not null
);

-- Lock the table down, then allow ONLY inserts from the public (anon) key.
-- Visitors can submit inquiries but can never read, edit, or delete them.
alter table public.inquiries enable row level security;

create policy "Anyone can submit an inquiry"
  on public.inquiries
  for insert
  to anon
  with check (true);

-- No select/update/delete policies for anon = submissions are write-only
-- from the website. You read them in the Supabase dashboard (Table Editor),
-- which uses your authenticated owner access.
