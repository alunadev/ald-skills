# My curated list of skills for any AI Agent: Antigravity and Claude Code

## What This Does
This repository is a curated collection of agentic skills designed to extend the capabilities of AI coding assistants like Antigravity and Claude Code. Each skill is a modular unit of specialized knowledge, workflows, and instructions.
This repository is a submodule of the ald-system repository.

## Quick Start Installation

### Option 1: Clone and Symlink (Recommended)

```bash
# Clone this repository
git clone https://github.com/alunadev/ald-skills.git
```

```bash
# Create symlink to Antigravity skills directory
# On macOS/Linux:
ln -s $(pwd)/ald-skills/* ~/.gemini/antigravity/skills/

# On Windows (run as Administrator):
mklink /D "C:\Users\YOUR-USER\.gemini\antigravity\skills" "C:\path\to\ald-skills\skills"

```
### Option 2: Manual Copy

```bash
# Clone this repository
git clone https://github.com/alunadev/ald-skills.git

# Copy skills to Antigravity directory
cp -r ald-skills/* ~/.gemini/antigravity/skills/
```

## 📝 Usage

Skills are automatically detected by Antigravity when placed in the skills directory. To use a skill:

1. Ensure the skill is in your `~/.gemini/antigravity/skills/` directory
2. Antigravity will automatically apply relevant skills based on context
3. You can also explicitly reference skills in your prompts

## Project Structure
- `skills/`: The core directory containing all standardized skill packages.
    - `brainstorming/`: Socratic discovery and technical design.
    - `brand-identity/`: Single Source of Truth for design, tech stack, and voice.
    - `planning/`: Atomic, TDD-focused implementation plans.
    - `error-handling-patterns/`: Robust strategies for resilient apps.
    - `react-best-practices/`: Performance optimization for React/Next.js.
    - `frontend-design/`: Distinctive, production-grade frontend interfaces.
    - `interface-design/`: Intentional interfaces for dashboards and SaaS.
    - `changelog-generator/`: Technical-to-User-friendly release notes.
    - `codebase-documenter/`: Beginner-friendly docs and architecture guides.
    - `creating-skills/`: Meta-skill for generating new standardized skills.
    - `deploying-to-github/`: Automated version control workflows.
    - `requesting-code-review/`: AI-powered code review subagent.
    - `running-inventory-tasks/`: LALIGA advertising inventory metrics.
- `workflows/`: Standardized automation flows.
- `GLOBAL_SKILLS.md`: A clean index and workflow integration guide.

## Key Concepts
- **Documentation-as-Code**: Each skill's documentation (`SKILL.md`) resides directly alongside its scripts and resources, making it version-controlled and executable by AI agents.
- **Gerund Naming**: Skill names use gerund forms (e.g., `implementing-error-handling`) to describe active capabilities.
- **Standardized Headers**: Every skill uses YAML frontmatter for clear discovery and triggering.

## Common Tasks
- **Adding a New Skill**: Use the `creating-skills` skill to generate a standardized directory structure.
- **Updating Documentation**: Follow the templates in `skills/codebase-documenter/assets/templates/`.

## 📚 References

### Official Documentation
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Antigravity Skills](https://antigravity.google/docs/skills)

### Curated Skill Collections
- [Awesome Claude Skills (VoltAgent)](https://github.com/VoltAgent/awesome-claude-skills)
- [Awesome Claude Skills (BehiSecc)](https://github.com/BehiSecc/awesome-claude-skills)
- [Agent Skills Marketplace](https://skills.sh/)

### Recommended External Skills
- **Security**: [varlock-claude-skill](https://github.com/varlock/varlock-claude-skill) - Secure environment variable management.
- **Testing**: [getsentry/find-bugs](https://github.com/getsentry/find-bugs), [getsentry/deslop](https://github.com/getsentry/deslop).
- **Deployment**: [vercel-labs/vercel-deploy-claimable](https://github.com/vercel-labs/vercel-deploy-claimable).
- **Mobile**: [Expo AI Skills](https://github.com/expo/expo) (expo-app-design, expo-deployment, upgrading-expo).

## Troubleshooting
- **Skill Not Loading**: Ensure the directory follows the `<skill-name>/SKILL.md` structure and is in the correct global skills folder.
- **Ambiguous Triggers**: Refine the `description` in the YAML frontmatter to include more specific keywords.

## 📬 Contact
If you want to contact me, you can reach me on [X](https://x.com/adrianlunadiaz).
