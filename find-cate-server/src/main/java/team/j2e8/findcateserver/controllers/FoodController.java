package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import team.j2e8.findcateserver.infrastructure.ObjectSelector;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.Food;
import team.j2e8.findcateserver.services.FoodService;
import team.j2e8.findcateserver.services.UserService;

import javax.annotation.Resource;

/**
 * @auther vinsonws
 * @date 2018/12/11 18:17
 */
@Controller
@RequestMapping(value = "/food")
public class FoodController {
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;
    @Autowired
    private UserService userService;
    @Autowired
    private FoodService foodService;

    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "serve")
    public ResponseEntity<?> serveFood(@RequestBody JsonNode jsonNode) {
        String foodName = jsonNode.path("food_name").textValue();
        int typeId = jsonNode.path("type_id").asInt();
        String foodPhoto = jsonNode.path("food_photo").textValue();
        float foodPrice = jsonNode.path("food_price").floatValue();
        int shopId = jsonNode.path("shop_id").asInt();
        foodService.shopServeDish(foodName, typeId, foodPhoto, foodPrice, shopId);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(null);
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.DELETE, value = "unserve")
    public ResponseEntity<?> unServeFood(@RequestBody JsonNode jsonNode) {
        int foodId = jsonNode.path("food_id").asInt();
        int shopId = jsonNode.path("shop_id").asInt();
        foodService.unServeDish(foodId, shopId);
        return ResponseEntity.status(HttpStatus.ACCEPTED).body(null);
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "gets")
    public ResponseEntity<?> getFoodsByShop(@RequestParam(required = true, defaultValue = "") Integer shopId,
                                            @RequestParam(value = "${spring.data.rest.page-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-number}") Integer pageNum,
                                            @RequestParam(value = "${spring.data.rest.limit-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-size}") Integer pageSize,
                                            @RequestParam(value = "${spring.data.rest.sort-param-name}", required = false, defaultValue = "foodId,desc") String sort) {
        Page<Food> foods = foodService.getFoodsByShop(shopId, sort, pageNum, pageSize);
        return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(foods, "(foodId, foodName, foodPrice, foodPhoto, type(typeId, typeName))"));

    }
}
