---
name: codebase-documenter
description: Create comprehensive, beginner-friendly documentation for codebases. Use when writing READMEs, architecture guides, code comments, or API documentation.
---

# Codebase Documenter

This skill enables creating comprehensive, beginner-friendly documentation for codebases. It provides structured templates and best practices for writing READMEs, architecture guides, code comments, and API documentation that help new users quickly understand and contribute to projects.

## When to use this skill
- Creating or updating project READMEs.
- Writing architecture overviews for complex systems.
- Adding explanatory comments to non-obvious code.
- Documenting public APIs and interfaces.
- Onboarding new developers to the project.

---

## Core Principles for Beginner-Friendly Documentation

- **Start with the "Why"**: Explain purpose before implementation.
- **Progressive Disclosure**: Present information in layers (simple to complex).
- **Provide Context**: Why does this code exist?
- **Include Examples**: Always show concrete usage.
- **Assume No Prior Knowledge**: Define terms and avoid jargon.
- **Visual Aids**: Use diagrams, flowcharts, and file trees.
- **Quick Wins**: Help users get running in < 5 minutes.

---

## Documentation Workflow

### Step 1: Analyze the Codebase
- Identify entry points and map dependencies.
- Map core abstractions and configuration.

### Step 2: Choose Documentation Type
- **README**: For root directories and major modules.
- **Architecture**: For system design and data flow.
- **Code Comments**: For complex logic and non-obvious algorithms.
- **API Documentation**: For endpoints and public interfaces.

### Step 3: Generate Documentation
Use the templates in `assets/templates/` and customize for the specific project.

### Step 4: Review for Clarity
Read as a beginner and verify that examples and instructions actually work.

---

## Documentation Types & Structures

### 1. README Documentation
Should include: What This Does, Quick Start, Project Structure, Key Concepts, Common Tasks, and Troubleshooting.

### 2. Architecture Documentation
Should include: System Design, Directory Structure, Data Flow, Key Design Decisions, Module Dependencies, and Extension Points.

### 3. Code Comments
Focus on explaining **why** instead of **what**. Include examples for complex functions and document edge cases.

### 4. API Documentation
Should include: Endpoint Name, Purpose, Auth, Request/Response formats, Example Usage (curl/code), and Common Errors.

---

## Templates & Resources
- `assets/templates/README.template.md`
- `assets/templates/ARCHITECTURE.template.md`
- `assets/templates/API.template.md`
- `assets/templates/CODE_COMMENTS.template.md`
- `references/documentation_guidelines.md`
- `references/visual_aids_guide.md`
