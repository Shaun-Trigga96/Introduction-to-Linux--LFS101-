#!/bin/bash

# Set Desktop path for Windows (WSL2 or Git Bash)
DESKTOP_PATH="$HOME/Desktop"

# Create main directory
mkdir -p "$DESKTOP_PATH/LFD259-Kubernetes-for-Developers"
cd "$DESKTOP_PATH/LFD259-Kubernetes-for-Developers" || exit

# Create chapter directories (01 to 11)
for i in $(seq -w 1 11); do
    mkdir -p "Chapter-$i"
    touch "Chapter-$i/README.md" "Chapter-$i/notes.md" "Chapter-$i/exercises.md"
    echo "# Chapter $i: $(echo "Chapter $i Title" | sed 's/0*//')" > "Chapter-$i/README.md"
    echo -e "## Learning Objectives\n- [ ] Objective 1\n- [ ] Objective 2\n## Key Topics\n1. Topic 1\n2. Topic 2\n## Time Allocation\n- Reading: 1 hour\n- Practice: 1 hour\n- Notes: 30 min\n## Resources\n- [Chapter slides]()\n- [Kubernetes docs](https://kubernetes.io)\n## Next Chapter\n[Next Chapter](../Chapter-$(printf %02d $((10#$i + 1)))/README.md)" >> "Chapter-$i/README.md"
    echo -e "# Chapter $i Notes\n\n## Key Concepts\n\n## Labs\n\n## CKAD/CKA Exam Tips" > "Chapter-$i/notes.md"
    echo -e "# Chapter $i Exercises\n\nRecord lab steps and outcomes here." > "Chapter-$i/exercises.md"
done

# Create additional directories
mkdir -p Labs-and-Exercises Cheat-Sheets Practice-Tests Resources Daily-Progress
touch Labs-and-Exercises/lab-01-app-deployment.md Labs-and-Exercises/lab-02-observability.md Labs-and-Exercises/lab-03-storage.md
touch Cheat-Sheets/kubectl-commands.md Cheat-Sheets/yaml-examples.md
touch Practice-Tests/ckad-simulator.md Practice-Tests/mock-exam.md
touch Resources/useful-links.md Resources/reference-materials.md
touch Daily-Progress/week-3-progress.md Daily-Progress/week-4-progress.md Daily-Progress/study-schedule.md
touch README.md PROGRESS.md settings.json

# Add content to additional files
echo -e "# LFD259 - Kubernetes for Developers\n\n## Course Overview\n- Duration: 2 weeks (July 18–31, 2025)\n- Study Time: 6–8 hours daily\n- Objective: Prepare for CKA/CKAD\n\n## Learning Path\n1. Week 3: Chapters 1–6\n2. Week 4: Chapters 7–11\n\n## Daily Schedule\n- Morning: Theory\n- Afternoon: Labs\n- Evening: Review" > README.md
echo -e "# Progress Tracking\n\n- [ ] Chapter 1: Course Introduction\n- [ ] Chapter 2: Kubernetes Architecture\n... (add all chapters)" > PROGRESS.md
echo -e "# Labs\n\n## Lab 1: App Deployment\n\n## Lab 2: Observability\n\n## Lab 3: Storage" > Labs-and-Exercises/lab-01-app-deployment.md
echo -e "# Cheat Sheets\n\n## kubectl Commands\n\n## YAML Examples" > Cheat-Sheets/kubectl-commands.md
echo -e "# Practice Tests\n\n## CKAD Simulator Notes\n\n## Mock Exam" > Practice-Tests/ckad-simulator.md
echo -e "# Resources\n\n- [Kubernetes Docs](https://kubernetes.io)\n- [KodeKloud](https://kodekloud.com)" > Resources/useful-links.md
echo -e "# Week 3 Progress\n\n## Completed\n- [ ] Task 1\n## Key Learnings\n1. Learning 1" > Daily-Progress/week-3-progress.md

# VS Code settings
cat <<EOL > settings.json
{
    "markdown.preview.breaks": true,
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "editor.wordWrap": "on",
    "explorer.compactFolders": false,
    "todo-tree.highlights.defaultHighlight": {
        "icon": "alert",
        "type": "tag",
        "foreground": "red",
        "background": "white",
        "opacity": 50
    },
    "todo-tree.highlights.customHighlight": {
        "TODO": {"icon": "check", "foreground": "black", "iconColour": "yellow"},
        "STUDY": {"icon": "book", "foreground": "white", "background": "blue"},
        "PRACTICE": {"icon": "tools", "foreground": "white", "background": "green"}
    }
}
EOL

echo "LFD259 folder structure created on Desktop."
