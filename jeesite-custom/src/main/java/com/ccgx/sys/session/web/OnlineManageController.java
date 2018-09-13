package com.ccgx.sys.session.web;

import com.thinkgem.jeesite.common.security.shiro.session.SessionDAO;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Collection;

@Controller
@RequestMapping(value = "${adminPath}/ol")
public class OnlineManageController {

    @Autowired
    private SessionDAO sessionDAO;

    @RequestMapping(value = {"list", ""})
    public String list(Model model) {
        Collection<Session> sessions = sessionDAO.getActiveSessions(false);
        model.addAttribute("sessions", sessions);
        return "ccgx/sys/online/onlineList";
    }
}
