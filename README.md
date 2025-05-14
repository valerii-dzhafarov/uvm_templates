
# UVM Template Library

This repository contains templates for creating components in a **UVM** verification environment.

## Attention please:

Templates contain pragmas below:

- `// ut_del_pragma_begin` and  `// ut_del_pragma_end` — a code between these pragmas will be deleted in template instance 
- `// ut_del_pragma`   — a codeline with this pragma at the  end of line will be deleted in template instance 
- `// ut_del_pragma_file` — a file with this pragma at the first line will be deleted in template instance 

This pragmas helps to test templates and keep template instance is clear

## 📦 Template Structure

- `comp1_env1_env/` — UVM Environment template
- `comp1_agent1_agent/` — UVM Agent template
- `dut/` — DUT (model of the stack) for templates testing

Each template uses placeholder prefixes: `comp1`, `env1`, and `agent1`, which will be automatically replaced during instantiation.

---

## ⚙️ Instantiation Script: `instant.py`

The script `instant.py` automatically:
1. **Copies the chosen template** (`env` or `agent`)
2. **Renames folders and files**
3. **Replaces all occurrences** of `comp1`, `env1`, and `agent1` in text and names
- `comp1`  -- company name
- `env1`   -- environment name
- `agent1` -- agent(bus) name
4. **Generates a ready-to-use UVM component** in the specified target directory

```bash
python3 ./instant.py -help
usage: instant.py [-h] [--mode {env,agent}] [--company COMPANY] [--name NAME] [--target_dir TARGET_DIR]

Template instantiation: copy and rename.

options:
  -h, --help            show this help message and exit
  --mode {env,agent}    Mode of operation: env or agent (default: env)
  --company COMPANY     Company name (default: work)
  --name NAME           Environment or agent name (default: project)
  --target_dir TARGET_DIR
                        Where to copy the template and instantiate (default: ./output)
```

### 🧪 Example usage:

```bash
python3 instant.py --mode agent --company hell --name axi --target_dir ./generated
```

### EDA playground agent, environment test:

https://www.edaplayground.com/x/XWDc

#### QuestaSim (2024.3)
- Compile options:

`-timescale 1ns/1ns -top comp1_env1_tb stack.sv comp1_agent1_if.sv comp1_agent1_pkg.sv comp1_env1_tb_if.sv comp1_env1_env_pkg.sv comp1_env1_test_pkg.sv comp1_env1_wrapper.sv comp1_env1_tb.sv`
- Runtime options:

`-voptargs=+acc=npr  +UVM_TESTNAME=env1_base_test`

#### Synopsys (2023.03)
- Compile options:

`-timescale=1ns/1ns +vcs+flush+all +warn=all -sverilog  -top comp1_env1_tb stack.sv comp1_agent1_if.sv comp1_agent1_pkg.sv comp1_env1_tb_if.sv comp1_env1_env_pkg.sv comp1_env1_test_pkg.sv comp1_env1_wrapper.sv comp1_env1_tb.sv`
- Runtime options:

`+UVM_TESTNAME=env1_base_test`

#### Cadence (23.09)
- Compile options:

`-timescale 1ns/1ns -sysv  -top comp1_env1_tb stack.sv comp1_agent1_if.sv comp1_agent1_pkg.sv comp1_env1_tb_if.sv comp1_env1_env_pkg.sv comp1_env1_test_pkg.sv comp1_env1_wrapper.sv comp1_env1_tb.sv`
- Runtime options:

`-access +rw  +UVM_TESTNAME=env1_base_test`
