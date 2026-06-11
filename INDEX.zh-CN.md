# 技能索引

## 主技能

### `sdd-tdd-development`

适用条件：

- 生产代码要新增或修改
- 不能只追求“写得快”
- 需要把行为、测试、验证、CI 和 PR 说明串起来

最适合：

- 新功能
- API 开发
- 业务逻辑修改
- 生产 bug 修复
- 抵抗纯 vibe-code 冲动

## 配套技能

### `legacy-safe-refactor`

适用条件：

- 旧代码脆弱
- 隐藏状态多
- 副作用多
- 主要风险是“改结构时破坏旧行为”

最适合：

- 先读后改
- current-state spec
- characterization tests
- 小步安全重构

## 选择规则

- Greenfield / 普通 bug：先用 `sdd-tdd-development`
- 老代码 / 高耦合 / 保行为优先：叠加 `legacy-safe-refactor`
