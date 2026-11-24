````Mermaid

## Table `organizacao`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_organizacao` | `uuid` | Primary |
| `nome_organizacao` | `text` |  |
| `organizacao_criado_em` | `timestamptz` |  |

## Table `unidade`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_unidade` | `uuid` | Primary |
| `id_org` | `uuid` |  |
| `nome` | `text` |  |
| `unidade_criado_em` | `timestamptz` |  |

## Table `membros_organizacao`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_org` | `uuid` | Primary |
| `id_usuario` | `uuid` | Primary |
| `funcao` | `text` |  |
| `ativo` | `bool` |  |
| `criado_em` | `timestamptz` |  |
| `endereco` | `text` |  Nullable |
| `num_end` | `text` |  Nullable |
| `bairro` | `text` |  Nullable |
| `cep` | `text` |  Nullable |
| `cidade` | `text` |  Nullable |
| `estado` | `text` |  Nullable |
| `complemento` | `text` |  Nullable |
| `celular` | `text` |  Nullable |
| `nome_contato_alternativo` | `text` |  Nullable |
| `celular_contato_alternativo` | `text` |  Nullable |
| `email` | `text` |  Nullable |

## Table `membro_unidade`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_unid` | `uuid` | Primary |
| `id_usuario` | `uuid` | Primary |
| `funcao` | `text` |  |
| `ativo` | `bool` |  |
| `criado_em` | `timestamptz` |  |

## Table `aluno`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_aluno` | `uuid` | Primary |
| `id_org` | `uuid` |  |
| `nome_completo_aluno` | `text` |  |
| `ativo` | `bool` |  |
| `aluno_criado_em` | `timestamptz` |  |
| `serie` | `text` |  |

## Table `aluno_unidade`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_aluno` | `uuid` | Primary |
| `id_org` | `uuid` |  |
| `id_unid` | `uuid` | Primary |
| `ativo` | `bool` |  |
| `criado_em` | `timestamptz` |  |

## Table `responsavel_aluno`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_aluno` | `uuid` | Primary |
| `id_usuario_responsavel` | `uuid` | Primary |
| `parentesco` | `text` |  Nullable |
| `criado_em` | `timestamptz` |  |

## Table `carteira`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_carteira` | `uuid` | Primary |
| `id_aluno` | `uuid` |  |
| `id_unid` | `uuid` |  |
| `saldo` | `numeric` |  |
| `criado_em` | `timestamptz` |  |

## Table `transferencia_carteira`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id` | `uuid` | Primary |
| `id_unid` | `uuid` |  |
| `carteira_destino` | `uuid` |  |
| `carteira_origem` | `uuid` |  |
| `valor` | `numeric` |  |
| `criado_por` | `uuid` |  Nullable |
| `criado_em` | `timestamptz` |  |

## Table `produto`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id` | `uuid` | Primary |
| `id_unidade` | `uuid` |  |
| `nome` | `text` |  |
| `preco` | `numeric` |  |
| `ativo` | `bool` |  |
| `produto_criado_em` | `timestamptz` |  |

## Table `estoque`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_unidade` | `uuid` | Primary |
| `id_produto` | `uuid` | Primary |
| `quantidade` | `numeric` |  |
| `atualizado_em` | `timestamptz` |  |

## Table `venda`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_venda` | `uuid` | Primary |
| `id_unid` | `uuid` |  |
| `id_aluno` | `uuid` |  Nullable |
| `id_usuario_funcionario` | `uuid` |  Nullable |
| `status` | `text` |  |
| `total` | `numeric` |  |
| `criado_em` | `timestamptz` |  |

## Table `itens_venda`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id` | `uuid` | Primary |
| `id_venda` | `uuid` |  |
| `id_unid` | `uuid` |  |
| `id_produto` | `uuid` |  |
| `quantidade` | `numeric` |  |
| `preco_unitario` | `numeric` |  |
| `total_itens` | `numeric` |  Nullable |

## Table `pagamento_venda`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id` | `uuid` | Primary |
| `id_venda` | `uuid` |  |
| `id_unid` | `uuid` |  |
| `metodo` | `text` |  |
| `valor` | `numeric` |  |
| `id_carteira` | `uuid` |  Nullable |
| `criado_em` | `timestamptz` |  |

## Table `movimentacao_carteira`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id` | `uuid` | Primary |
| `id_carteira` | `uuid` |  |
| `id_unid` | `uuid` |  |
| `id_venda` | `uuid` |  Nullable |
| `id_transferencia` | `uuid` |  Nullable |
| `tipo` | `text` |  |
| `valor` | `numeric` |  |
| `chave_transferencia` | `text` |  Nullable Unique |
| `criado_por` | `uuid` |  Nullable |
| `criado_em` | `timestamptz` |  |

## RLS Policies

### `membros_organizacao`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read own organization memberships` | SELECT | authenticated | PERMISSIVE | `(id_usuario = ( SELECT auth.uid() AS uid))` | — |

### `unidade`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible units` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM membros_organizacao om   WHERE ((om.id_org = unidade.id_org) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))) OR (EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = unidade.id_unidade) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))))` | — |

### `aluno_unidade`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible student units` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM responsavel_aluno g   WHERE ((g.id_aluno = aluno_unidade.id_aluno) AND (g.id_usuario_responsavel = ( SELECT auth.uid() AS uid))))) OR (EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = aluno_unidade.id_unid) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))) OR (EXISTS ( SELECT 1    FROM membros_organizacao om   WHERE ((om.id_org = aluno_unidade.id_org) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |

### `responsavel_aluno`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read own guardian links` | SELECT | authenticated | PERMISSIVE | `(id_usuario_responsavel = ( SELECT auth.uid() AS uid))` | — |

### `carteira`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible wallets` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM responsavel_aluno g   WHERE ((g.id_aluno = carteira.id_aluno) AND (g.id_usuario_responsavel = ( SELECT auth.uid() AS uid))))) OR (EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = carteira.id_unid) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))) OR (EXISTS ( SELECT 1    FROM (unidade u      JOIN membros_organizacao om ON ((om.id_org = u.id_org)))   WHERE ((u.id_unidade = carteira.id_unid) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |

### `transferencia_carteira`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible wallet transfers` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM carteira w   WHERE ((w.id_carteira = transferencia_carteira.carteira_destino) AND (w.id_unid = transferencia_carteira.id_unid)))) OR (EXISTS ( SELECT 1    FROM carteira w   WHERE ((w.id_carteira = transferencia_carteira.carteira_origem) AND (w.id_unid = transferencia_carteira.id_unid)))))` | — |

### `venda`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit sales` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = venda.id_unid) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))) OR (EXISTS ( SELECT 1    FROM (unidade u      JOIN membros_organizacao om ON ((om.id_org = u.id_org)))   WHERE ((u.id_unidade = venda.id_unid) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |

### `itens_venda`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit sale items` | SELECT | authenticated | PERMISSIVE | `(EXISTS ( SELECT 1    FROM venda s   WHERE ((s.id_venda = itens_venda.id_venda) AND (s.id_unid = itens_venda.id_unid))))` | — |

### `pagamento_venda`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit sale payments` | SELECT | authenticated | PERMISSIVE | `(EXISTS ( SELECT 1    FROM venda s   WHERE ((s.id_venda = pagamento_venda.id_venda) AND (s.id_unid = pagamento_venda.id_unid))))` | — |

### `movimentacao_carteira`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible wallet transactions` | SELECT | authenticated | PERMISSIVE | `(EXISTS ( SELECT 1    FROM carteira w   WHERE ((w.id_carteira = movimentacao_carteira.id_carteira) AND (w.id_unid = movimentacao_carteira.id_unid))))` | — |

### `organizacao`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read member organizations` | SELECT | authenticated | PERMISSIVE | `(EXISTS ( SELECT 1    FROM membros_organizacao m   WHERE ((m.id_org = organizacao.id_organizacao) AND (m.id_usuario = ( SELECT auth.uid() AS uid)) AND m.ativo)))` | — |

### `estoque`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit inventory` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = estoque.id_unidade) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))) OR (EXISTS ( SELECT 1    FROM (unidade u      JOIN membros_organizacao om ON ((om.id_org = u.id_org)))   WHERE ((u.id_unidade = estoque.id_unidade) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |

### `aluno`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read accessible students` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM responsavel_aluno g   WHERE ((g.id_aluno = aluno.id_aluno) AND (g.id_usuario_responsavel = ( SELECT auth.uid() AS uid))))) OR (EXISTS ( SELECT 1    FROM aluno_unidade su   WHERE (su.id_aluno = aluno.id_aluno))))` | — |

### `produto`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit products` | SELECT | authenticated | PERMISSIVE | `((EXISTS ( SELECT 1    FROM membro_unidade um   WHERE ((um.id_unid = produto.id_unidade) AND (um.id_usuario = ( SELECT auth.uid() AS uid)) AND um.ativo))) OR (EXISTS ( SELECT 1    FROM (unidade u      JOIN membros_organizacao om ON ((om.id_org = u.id_org)))   WHERE ((u.id_unidade = produto.id_unidade) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |

### `membro_unidade`

| Policy | Command | Roles | Action | USING | WITH CHECK |
|--------|---------|-------|--------|-------|------------|
| `read unit memberships as org admin` | SELECT | authenticated | PERMISSIVE | `((id_usuario = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM (unidade u      JOIN membros_organizacao om ON ((om.id_org = u.id_org)))   WHERE ((u.id_unidade = membro_unidade.id_unid) AND (om.id_usuario = ( SELECT auth.uid() AS uid)) AND om.ativo))))` | — |
| `read own unit memberships` | SELECT | authenticated | PERMISSIVE | `(id_usuario = ( SELECT auth.uid() AS uid))` | — |

```