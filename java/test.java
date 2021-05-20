import java.util.Arrays;
public class Test {
    public static void main(String[] args) {
       new Test();
    }

    Test() {
        try{
            parentMethod();
        } catch (Exception e) {
            // e.printStackTrace();
            System.err.println(e.getCause());
            System.err.println(e.getMessage());
            StackTraceElement[] stackTraces = e.getStackTrace();
            StringBuilder sb = new StringBuilder();

            for(int i = 1; i < 100; i++) {
              int index = stackTraces.length - i;
              if (index < 0) {
                break;
              }
              StackTraceElement s = stackTraces[index];
              // if(s == stackTraces[0]) continue;
              sb.append(String.format("\tat %s(%s:%s)\n", s.getMethodName(), s.getFileName(), s.getLineNumber()));
            }

            System.err.println(sb.toString());
            // throw new AssertionError(e);
        }
    }

    void parentMethod() throws HiLevelException {
        try {
            childMethod();
        } catch (Exception e) {
            throw new HiLevelException("HiLevel", e);
        }
    }

    void childMethod() throws LowLevelException {
        throw new LowLevelException("LowLevel");
    }
}

class HiLevelException extends Exception {
    HiLevelException(String msg, Throwable cause) {
        super(msg, cause);
    }
}

class LowLevelException extends Exception {
    LowLevelException(String msg) {
        super(msg);
    }
}

