/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.security;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.StrutsStatics;
import static org.apache.struts2.StrutsStatics.HTTP_REQUEST;

/**
 *
 * @author nishant.vibhute
 */
public class ActionSecurity extends AbstractInterceptor implements StrutsStatics {

    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        ActionContext context = invocation.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest) context.get(HTTP_REQUEST);
        HttpSession session = request.getSession(false);

        // session will almost *never* be null. Check for a valid user object.
        if (session == null || session.getAttribute("logined") == null) {
            return "failed";
        }

        return invocation.invoke();
    }

}
