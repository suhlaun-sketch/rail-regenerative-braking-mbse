import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import org.eclipse.xtext.validation.Issue;
import org.omg.sysml.interactive.SysMLInteractive;
import org.omg.sysml.interactive.SysMLInteractiveResult;

/** Thin command-line wrapper around the official SysML v2 0.59.0 Jupyter kernel. */
public final class OfficialSysMLValidator {
    private OfficialSysMLValidator() {}

    private static String json(String value) {
        if (value == null) return "null";
        StringBuilder out = new StringBuilder("\"");
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '\\': out.append("\\\\"); break;
                case '"': out.append("\\\""); break;
                case '\n': out.append("\\n"); break;
                case '\r': out.append("\\r"); break;
                case '\t': out.append("\\t"); break;
                default:
                    if (c < 0x20) out.append(String.format("\\u%04x", (int)c));
                    else out.append(c);
            }
        }
        return out.append('"').toString();
    }

    private static void appendIssues(StringBuilder out, List<Issue> issues) {
        out.append('[');
        for (int i = 0; i < issues.size(); i++) {
            if (i > 0) out.append(',');
            Issue issue = issues.get(i);
            out.append('{')
               .append("\"severity\":").append(json(String.valueOf(issue.getSeverity()))).append(',')
               .append("\"syntax_error\":").append(issue.isSyntaxError()).append(',')
               .append("\"message\":").append(json(issue.getMessage())).append(',')
               .append("\"code\":").append(json(issue.getCode())).append(',')
               .append("\"line\":").append(issue.getLineNumber() == null ? "null" : issue.getLineNumber()).append(',')
               .append("\"column\":").append(issue.getColumn() == null ? "null" : issue.getColumn())
               .append('}');
        }
        out.append(']');
    }

    public static void main(String[] args) throws Exception {
        if (args.length != 3) {
            System.err.println("usage: OfficialSysMLValidator <library-dir> <model.sysml> <report.json>");
            System.exit(2);
        }
        Path library = Path.of(args[0]).toAbsolutePath().normalize();
        Path model = Path.of(args[1]).toAbsolutePath().normalize();
        Path report = Path.of(args[2]).toAbsolutePath().normalize();
        String source = Files.readString(model, StandardCharsets.UTF_8);

        SysMLInteractive interactive = SysMLInteractive.createInstance();
        interactive.loadLibrary(library.toString());
        SysMLInteractiveResult result = interactive.process(source, false);

        List<Issue> syntax = result.getSyntaxErrors();
        List<Issue> semantic = result.getSemanticErrors();
        List<Issue> warnings = result.getWarnings();
        StringBuilder out = new StringBuilder();
        out.append('{')
           .append("\"validator\":\"official SysML v2 Pilot Jupyter kernel\",")
           .append("\"kernel_version\":\"0.59.0\",")
           .append("\"model\":").append(json(model.toString())).append(',')
           .append("\"syntax_error_count\":").append(syntax.size()).append(',')
           .append("\"semantic_error_count\":").append(semantic.size()).append(',')
           .append("\"warning_count\":").append(warnings.size()).append(',')
           .append("\"exception\":").append(json(result.getException() == null ? null : result.getException().toString())).append(',')
           .append("\"syntax_errors\":");
        appendIssues(out, syntax);
        out.append(",\"semantic_errors\":");
        appendIssues(out, semantic);
        out.append(",\"warnings\":");
        appendIssues(out, warnings);
        out.append('}');

        Files.createDirectories(report.getParent());
        Files.writeString(report, out.toString(), StandardCharsets.UTF_8);
        System.out.printf("syntax=%d semantic=%d warnings=%d exception=%s%n",
                syntax.size(), semantic.size(), warnings.size(), result.getException());
        if (result.getException() != null || !syntax.isEmpty() || !semantic.isEmpty()) System.exit(1);
    }
}
