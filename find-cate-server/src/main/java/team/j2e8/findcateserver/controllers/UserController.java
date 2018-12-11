package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.User;
import team.j2e8.findcateserver.services.UserService;
import team.j2e8.findcateserver.utils.JwtHelper;

import javax.annotation.Resource;

/**
 * @auther vinsonws
 * @date 2018/11/30 16:19
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;
    @Autowired
    private UserService userService;
    @Autowired
    private JwtHelper jwtHelper;
    @Value("${token.issuer}")
    private String issuer;
    @Value("${token.expired_in}")
    private int expiredIn;

    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "/login")
    public ResponseEntity<?> login(@RequestBody JsonNode jsonNode) throws Exception {
        //用户认证
        String email = jsonNode.path("user_email").textValue();
        String password = jsonNode.path("password").textValue();
        User user = userService.verifyUserByEmail(email, password);
        //token颁发
        return ResponseEntity.ok(jwtHelper.getToken(issuer, expiredIn, user));
    }
    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "/register")
    public ResponseEntity<?> register(@RequestBody JsonNode jsonNode) throws Exception {
        String email = jsonNode.path("user_email").textValue();
        String userName = jsonNode.path("user_name").textValue();
        String userTelenumber = jsonNode.path("user_telenumber").textValue();
        String userPhoto = jsonNode.path("user_photo").textValue();
        String password = jsonNode.path("password").textValue();
        userService.registerUserByEmail(email, userName, userTelenumber, userPhoto, password);
        return ResponseEntity.status(HttpStatus.CREATED).body(null);
    }
}
