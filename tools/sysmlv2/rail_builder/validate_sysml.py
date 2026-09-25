import json, subprocess, sys
from common import PROJECT_ROOT, VALIDATION, GENERATED, write_text

def validate(model, report):
    jar=PROJECT_ROOT/'third_party/sysmlv2/parser_runtime/runtime/sysml/jupyter-sysml-kernel-0.59.0-all.jar'; classes=PROJECT_ROOT/'tools/sysmlv2/.classes'; library=PROJECT_ROOT/'third_party/sysmlv2/parser_runtime/runtime/sysml/sysml.library'
    cmd=['java','-cp',str(classes)+';'+str(jar),'OfficialSysMLValidator',str(library),str(model),str(report)]
    p=subprocess.run(cmd,text=True,encoding='utf-8',errors='replace',stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    return p, json.loads(report.read_text(encoding='utf-8'))

def main():
    model=GENERATED/'Rail_MBSE_Full_v1.sysml'; report=VALIDATION/'Official_SysML_Validation.json'; p,data=validate(model,report)
    md=f"""# Official SysML v2 Validation Report

- Runtime: official SysML v2 Pilot Jupyter kernel
- Version: 0.59.0
- Command: `java -cp <classes>;<jupyter-sysml-kernel-0.59.0-all.jar> OfficialSysMLValidator <library> <model> <report>`
- Parsed files: `{model}`
- Syntax Error Count: {data['syntax_error_count']}
- Semantic Error Count: {data['semantic_error_count']}
- Warnings: {data['warning_count']}
- Exception: {data['exception']}
- Status: {'PASS' if p.returncode==0 else 'FAIL'}
"""
    write_text(VALIDATION/'Official_SysML_Validation_Report.md',md); print(p.stdout); print(json.dumps(data,ensure_ascii=False)); return p.returncode
if __name__=="__main__": sys.exit(main())

