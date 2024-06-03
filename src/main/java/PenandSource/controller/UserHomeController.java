package PenandSource.controller;

import PenandSource.Rq;

public class UserHomeController extends Controller {

    @Override
    public void performAction(Rq rq) {
        switch (rq.getActionMethodName()) {
            case "main" -> showMain(rq);
            default -> rq.println("존재하지 않는 페이지 입니다.");
        }
    }
    public void showMain(Rq rq) {
        rq.jsp("home/main");
    }
}
