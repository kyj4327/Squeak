package PenandSource;

import PenandSource.util.Ut;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class Rq {
    @Getter
    private final HttpServletRequest req;
    @Getter
    private final HttpServletResponse resp;
    @Getter
    private boolean isInvalid = false;
    @Getter
    private String controllerTypeName;
    @Getter
    private String controllerName;
    @Getter
    private String actionMethodName;

    public Rq(HttpServletRequest req, HttpServletResponse resp) {
        this.req = req;
        this.resp = resp;

        // 한글 입력을 위한 인코더 등록
        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset-ut-8");

        String requestURI = req.getRequestURI();
        String[] requestURIBits = requestURI.split("/"); // / 기준으로 Uri 쪼개

        /*
        /user/diary/list ->> 0/1[user]/2[diary]/3[list]
         */
        int minBitsCount = 4;


        if (requestURIBits.length < minBitsCount) {
            isInvalid = true;
            return;
        }
        int controllerTypeNameIndex = 1;
        int controllerNameIndex = 2;
        int controllerMethodNameIndex = 3;

        controllerTypeName = requestURIBits[controllerTypeNameIndex];
        controllerName = requestURIBits[controllerNameIndex];
        actionMethodName = requestURIBits[controllerMethodNameIndex];
    }


    public int getIntParam(String paramName, int defaultValue) {
        String value = req.getParameter(paramName);

        if (value == null) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value);
        } catch (NullPointerException e) {
            return defaultValue;
        }
    }
    public String getParam(String paramName, String defaultValue){
        String value = req.getParameter(paramName);

//        if (value.replace('\u00A0',' ').trim().equals("")) {
        if (value == null) {
            return defaultValue;
        }
        return value;
    }

    // 출력.
    public void print(String str) {        try {
        resp.getWriter().append(str);
    } catch (IOException e) {
        throw new RuntimeException(e);
    }
    }
    public void println(String str) {
        print(str + "\n");
    }

    public void printf(String format, Object... args) {
        print(Ut.f(format, args));
    }

    public void historyBack(String msg) {
        println("<script>");
        printf("alert('%s');\n", msg);
        printf("history.back();", msg);
        println("</script>");
    }

    public void replace(String msg, String redirectURI) {
        println("<script>");
        printf("alert('%s');\n", msg);
        printf("location.replace('%s');", redirectURI);
        println("</script>");
    }

    //  map 처럼 저장한다 -> name 기준 Object 형 값 저장
    public void setAttr(String name, Object value){
        req.setAttribute(name,value);
    }
    // get = name 기준으로 값을 가져온다.
    public Object getAttr(String name){
        return req.getAttribute(name);
    }

    public void jsp(String jspPath) {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/" + jspPath + ".jsp");
        try {
            requestDispatcher.forward(req, resp);
        } catch (ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public HttpSession getSession() {
        HttpSession session = req.getSession();
        return session;
    }
}