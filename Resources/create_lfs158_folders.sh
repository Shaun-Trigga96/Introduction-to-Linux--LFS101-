```bash
#!/bin/bash

# Set Desktop path for Windows (WSL2 or Git Bash)
DESKTOP_PATH="$HOME/Desktop"

# Create main directory
mkdir -p "$DESKTOP_PATH/LFS158-Introduction-to-Kubernetes"
cd "$DESKTOP_PATH/LFS158-Introduction-to-Kubernetes" || exit

# Create chapter directories (01 to 16)
for i in $(seq -w 1 16); do
    mkdir -p "Chapter-$i"
    touch "Chapter-$i/README.md" "Chapter-$i/notes.md" "Chapter-$i/exercises.md"
    echo "# Chapter $i: $(echo "Chapter $i Title" | sed 's/0*//')" > "Chapter-$i/README.md"
    echo -e "## Learning Objectives\n- [ ] Objective 1\n- [ ] Objective 2\n## Key Topics\n1. Topic 1\n2. Topic 2\n## Time Allocation\n- Reading: 1 hour\n- Practice: 1 hour\n- Notes: 30 min\n## Resources\n- [Chapter slides]()\n- [Kubernetes docs](https://kubernetes.io)\n## Next Chapter\n[Next Chapter](../Chapter-$(printf %02d $((10#$i + 1)))/README.md)" >> "Chapter-$i/README.md"
    echo -e "# Chapter $i Notes\n\n## Key Concepts\n\n## Labs\n\n## CKA Exam Tips" > "Chapter-$i/notes.md"
    echo -e "# Chapter $i Exercises\n\nRecord lab steps and outcomes here." > "Chapter-$i/exercises.md"
done

# Create additional directories
mkdir -p Labs-and-Exercises Cheat-Sheets Practice-Tests Resources Daily-Progress
touch Labs-and-Exercises/lab-01-pod-deployment.md Labs-and-Exercises/lab-02-services.md Labs-and-Exercises/lab-03-troubleshooting.md
touch Cheat-Sheets/kubectl-commands.md Cheat-Sheets/yaml-examples.md
touch Practice-Tests/cka-simulator.md Practice-Tests/mock-exam.md
touch Resources/useful-links.md Resources/reference-materials.md
touch Daily-Progress/week-1-progress.md Daily-Progress/week-2-progress.md Daily-Progress/study-schedule.md
touch README.md PROGRESS.md settings.json

# Add content to additional files
echo -e "# LFS158 - Introduction to Kubernetes\n\n## Course Overview\n- Duration: 2 weeks (July 4–17, 2025)\n- Study Time: 6–8 hours daily\n- Objective: Prepare for CKA\n\n## Learning Path\n1. Week 1: Chapters 1–7\n2. Week 2: Chapters 8–16\n\n## Daily Schedule\n- Morning: Theory\n- Afternoon: Labs\n- Evening: Review" > README.md
echo -e "# Progress Tracking\n\n- [ ] Chapter 1: Course Introduction\n- [ ] Chapter 2: Basics of Kubernetes\n... (add all chapters)" > PROGRESS.md
echo -e "# Labs\n\n## Lab 1: Pod Deployment\n\n## Lab 2: Services\n\n## Lab 3: Troubleshooting" > Labs-and-Exercises/lab-01-pod-deployment.md
echo -e "# Cheat Sheets\n\n## kubectl Commands\n\n## YAML Examples" > Cheat-Sheets/kubectl-commands.md
echo -e "# Practice Tests\n\n## CKA Simulator Notes\n\n## Mock Exam" > Practice-Tests/cka-simulator.md
echo -e "# Resources\n\n- [Kubernetes Docs](https://kubernetes.io)\n- [Killer.sh](https://killer.sh)" > Resources/useful-links.md
echo -e "# Week 1 Progress\n\n## Completed\n- [ ] Task 1\n## Key Learnings\n1. Learning 1" > Daily-Progress/week-1-progress.md

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

echo "LFS158 folder structure created on Desktop."
```