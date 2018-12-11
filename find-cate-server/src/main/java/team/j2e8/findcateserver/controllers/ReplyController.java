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
import team.j2e8.findcateserver.services.ReplyService;

/**
 * @auther Heyanhu
 * @date 2018/12/11 21:55
 */
@Controller
@RequestMapping(value = "/reply")
public class ReplyController {
    @Autowired
    private ReplyService replyService;
    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "/replys")
    public ResponseEntity<?> comment(@RequestBody JsonNode jsonNode) throws Exception {
        String replyContent = jsonNode.path("reply_comtent").textValue();
        int cid = jsonNode.path("commity_id").intValue();
        replyService.insertReply(cid,replyContent);
        return ResponseEntity.status(HttpStatus.CREATED).body(null);
    }
}
