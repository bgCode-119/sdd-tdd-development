# SDD + TDD 开发技能包

这是一套给 AI Coding 使用的可复用技能包，目标不是让 AI 只会“写得快”，而是让它：

- 先定义正确性
- 再把正确性变成可验证检查
- 先证明失败，再最小实现
- 最后用测试、契约、CI、PR 说明把结果沉淀下来

## 包含的技能

### `sdd-tdd-development`

适用场景：

- 新功能开发
- 线上 bug 修复
- API / endpoint 开发
- 业务逻辑修改
- “先快点写出来”但又不能牺牲正确性的生产代码

核心流程：

1. 先分类任务
2. 先写小规格（spec）
3. 再从 spec 推导 checks
4. 先证明 RED
5. 再做最小 GREEN
6. 绿后才允许 refactor
7. 补 durable artifacts

一句话理解：

- `SDD` 定义“什么算对”
- `TDD` 把“对”变成机器可验证的证据

### `legacy-safe-refactor`

适用场景：

- 脆弱老代码
- god file / god class
- 有 hidden state / side effects 的老模块
- 想做结构清理，但必须保证行为不变

核心流程：

1. 先只读梳理
2. 写 current-state spec
3. 用 characterization tests 锁当前行为
4. 小步重构
5. 把可疑 bugfix 和结构重构隔离开

一句话理解：

- 先理解旧代码今天怎么工作
- 再锁行为
- 最后才动结构

## 如何选择技能

- 新功能 / 普通 bug：先用 `sdd-tdd-development`
- 老代码 / 高耦合 / 保行为优先：加上 `legacy-safe-refactor`

边界例子：

- “做一个新的支付 API” -> `sdd-tdd-development`
- “拆五年前的 checkout 大文件，别改坏行为” -> `legacy-safe-refactor`

## 仓库结构

```text
skills/
  sdd-tdd-development/
  legacy-safe-refactor/
scripts/
  install-codex-skills.ps1
  install-codex-skills.cmd
INDEX.md
INDEX.zh-CN.md
README.md
README.zh-CN.md
```

## 安装方式

### PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1
```

默认安装到：

- `%USERPROFILE%\.agents\skills`

自定义目录：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -TargetDir "E:\myrepo\.agents\skills"
```

### CMD

```bat
scripts\install-codex-skills.cmd
```

## 如何使用

### 新功能

```text
Use sdd-tdd-development for this feature.
Define a small spec first, derive checks, prove RED, do minimum GREEN, then list durable artifacts to update.
```

中文意图：

- 先给小规格
- 再列检查项
- 先失败
- 再最小实现
- 最后说明要更新哪些文档、测试、契约、CI 信息

### 小 bug

```text
Use sdd-tdd-development for this bug.
Add the regression test first, then do the smallest fix. No opportunistic refactor.
```

中文意图：

- 先补回归测试
- 再做最小修复
- 不顺手扩 scope

### 老代码安全重构

```text
Use legacy-safe-refactor for this module.
Read first, write current-state spec, lock behavior with characterization tests, then refactor in small verified slices.
Do not silently change suspicious old behavior.
```

中文意图：

- 第一遍只读不改
- 写 current-state spec
- 先锁当前行为
- 再小步重构
- 可疑旧逻辑不能顺手修

## 使用建议

推荐让 AI 按这种结构输出：

1. 任务分类
2. spec 或 current-state summary
3. tests / verification plan
4. RED evidence
5. minimal implementation
6. GREEN verification
7. refactor notes
8. artifact updates / PR notes

## 备注

- `sdd-tdd-development` 是主技能
- `legacy-safe-refactor` 是配套技能
- 每个技能的 `evals/` 目录里保留了 benchmark 和调优材料，方便后续维护

## 当前版本

- `sdd-tdd-development`: `0.3.0`
- `legacy-safe-refactor`: `0.2.1`
