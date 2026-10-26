-- 복지 AI 앱스페이스 즐겨찾기 테이블
-- Supabase 대시보드 > SQL Editor에 붙여 넣고 Run 하세요.

create table if not exists public.favorites (
  user_id    uuid not null default auth.uid() references auth.users (id) on delete cascade,
  app_key    text not null,
  created_at timestamptz not null default now(),
  primary key (user_id, app_key)
);

-- 본인 즐겨찾기만 보고, 추가하고, 지울 수 있도록 제한
alter table public.favorites enable row level security;

create policy "본인 즐겨찾기 조회" on public.favorites
  for select to authenticated using (user_id = auth.uid());
create policy "본인 즐겨찾기 추가" on public.favorites
  for insert to authenticated with check (user_id = auth.uid());
create policy "본인 즐겨찾기 삭제" on public.favorites
  for delete to authenticated using (user_id = auth.uid());
