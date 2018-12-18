package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import team.j2e8.findcateserver.infrastructure.ObjectSelector;
import team.j2e8.findcateserver.models.Commity;
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

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "/gets")
    public ResponseEntity<?> getCommentByShopId(@RequestParam Integer shopId,
                                                @RequestParam(value = "${spring.data.rest.page-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-number}") Integer pageNum,
                                                @RequestParam(value = "${spring.data.rest.limit-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-size}") Integer pageSize,
                                                @RequestParam(value = "${spring.data.rest.sort-param-name}", required = false, defaultValue = "commityId") String sort
    ) throws Exception {

        Page<Commity> commityPage = commityService.getCommentsByShopId(shopId, sort, pageNum, pageSize);
        return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(commityPage, "(commityId, commityContent, commityTime,user(id,userName),replyList(replyId, replyContent, replyTime,user(id,userName)))"));
    }
}
