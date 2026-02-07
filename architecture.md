# Architecture Overview

This repository follows a **modular, decentralised architecture** where each "skill" is a self-contained unit of capability. This design enables high reusability and ensures that AI agents can load only the context they need for a specific task.

## Directory Structure

```bash
ald-skills/
├── README.md               # Quick start and repo overview
├── architecture.md        # This document
├── skills/                # Core directory for all agentic skills
│   ├── <skill-name>/      # Standardized skill package
│   │   ├── SKILL.md       # Entry point: YAML frontmatter + instructions
│   │   ├── resources/     # (Optional) Templates, tokens, or guidelines
│   │   ├── scripts/       # (Optional) Executable helper scripts
│   │   └── references/    # (Optional) Deep-dive documentation
│   └── GLOBAL_SKILLS.md   # Skill index and workflow guide
└── workflows/             # Multi-step automation sequences
```

## Data Flow
1.  **Discovery**: Upon task initiation, the AI agent scans the global `skills` directory.
2.  **Triggering**: Based on the `name` and `description` in the YAML frontmatter of `SKILL.md` files, the agent selects relevant skills.
3.  **Execution**: The agent interprets the `Workflow` and `Instructions` in the selected `SKILL.md`.
4.  **Feedback**: If resources or scripts are needed, the agent follows the file paths specified in the instructions.

## Key Design Decisions
- **Standardized Entry Point**: Every skill must have a `SKILL.md` to ensure predictable agent behavior.
- **Decoupled Skills**: Skills are independent of each other (with rare exceptions) to prevent cascading context bloat.
- **Documentation-as-Code**: Instructions are written in Markdown to be both human-readable and machine-interpretable.

## External Integrations
This repository is designed to be compatible with the broader AI agent ecosystem:
- **skills.sh Compatibility**: Skill names and descriptions follow the naming conventions of the Agent Skills Marketplace.
- **Cross-Platform**: While optimized for Antigravity, the `SKILL.md` format is compatible with Claude Code and other MCP-enabled agents.
- **Curated Extensions**: The repository references external high-quality skills for specialized tasks (e.g., Sentry for bug finding, Vercel for deployment).

## Project Identification
- **Project Name**: Creative Skills Repository
- **Lead Developer**: Adrian Luna Diaz
- **Date of Last Update**: 2026-02-07
