create table public.cantina_profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  nome text,
  email text,
  role text not null default 'responsavel'
    check (role in ('responsavel', 'operador', 'gestor')),
  criado_em timestamptz not null default now()
);

alter table public.cantina_profiles enable row level security;

revoke all on public.cantina_profiles from anon, authenticated;
grant select on public.cantina_profiles to authenticated;

create policy "Usuarios consultam apenas o proprio perfil"
  on public.cantina_profiles for select to authenticated
  using ((select auth.uid()) = id);

create function public.handle_new_cantina_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.cantina_profiles (id, nome, email)
  values (new.id, nullif(trim(new.raw_user_meta_data ->> 'nome'), ''), new.email);
  return new;
end;
$$;

create trigger on_cantina_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_cantina_user();

insert into public.cantina_profiles (id, nome, email)
select id, nullif(trim(raw_user_meta_data ->> 'nome'), ''), email
from auth.users
on conflict (id) do nothing;
