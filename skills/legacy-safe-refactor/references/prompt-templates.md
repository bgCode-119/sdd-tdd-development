# Prompt Templates

## 1. Read-only legacy analysis

```text
请只读这段遗留代码，不要修改任何文件。

输出：
1. 入口清单 / public API
2. 职责分块
3. 状态地图：数据库、全局变量、缓存、配置、事件、日志
4. 隐藏契约清单：public import 路径、下游直接依赖、事件/日志格式
5. 可疑行为清单

目标是先理解现状，不是立刻重构。
```

## 2. Current-state spec

```text
请基于当前遗留模块写一份 current-state spec。

要求：
- 写“它今天怎么工作”，不是“它理想中应该怎么工作”
- 包含入口、输入/输出、状态变更、副作用、已知怪异行为
- 明确本次重构的非目标：默认不改外部行为
```

## 3. Characterization tests

```text
请先为当前行为补 characterization tests / feature tests，再谈重构。

要求：
- 覆盖 happy path、边界、错误路径、关键副作用、可疑旧行为
- reset 数据库、缓存、全局变量，保证测试可重复
- 不要顺手修 bug
```

## 4. Safe refactor slice

```text
当前行为已被测试锁住。请只做一个小步安全重构。

限制：
- 保持 public API 稳定
- 一次只动一个职责块
- 每步后都重跑相关测试
- 如果红灯，先解释行为漂移，再给最小修复
- 不要扩大 scope
```

## 5. Legacy refactor PR note

```text
请为这次遗留重构生成 PR 说明。

必须写清：
1. 哪些行为被特征测试锁住
2. 哪些结构被重构了
3. 哪些可疑旧行为故意没修
4. 本次验证命令和结果
5. 剩余需要人工裁决的风险
```

