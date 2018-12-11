package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import team.j2e8.findcateserver.services.CommityService;

/**
 * @auther Heyanhu
 * @date 2018/12/11 20:22
 */
@Controller
@RequestMapping(value = "/commity")
public class CommityController {
    @Autowired
    private CommityService commityService;
    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "/comment")
    public ResponseEntity<?> comment(@RequestBody JsonNode jsonNode) throws Exception {
        String comments = jsonNode.path("comment").textValue();
        int sid = jsonNode.path("shop_id").intValue();
        commityService.insertComments(sid,comments);
        return ResponseEntity.status(HttpStatus.CREATED).body(null);
    }
}
