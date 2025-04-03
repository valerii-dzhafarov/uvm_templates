
# UVM Template Library

This repository contains templates for creating components in a **UVM** verification environment.

## 📦 Template Structure

- `comp1_env1_env/` — UVM Environment template:
- `comp1_agent1_agent/` — UVM Agent template:

Each template uses placeholder prefixes: `comp1`, `env1`, and `agent1`, which will be automatically replaced during instantiation.

---

## ⚙️ Instantiation Script: `instant.py`

The script `instant.py` automatically:
1. **Copies the chosen template** (`env` or `agent`)
2. **Renames folders and files**
3. **Replaces all occurrences** of `comp1`, `env1`, and `agent1` in text and names
4. **Generates a ready-to-use UVM component** in the specified target directory

### 🧪 Example usage:

```bash
python instant.py --mode agent --company hell --name axi --target_dir ./generated
