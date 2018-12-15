package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import team.j2e8.findcateserver.infrastructure.ObjectSelector;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.Shop;
import team.j2e8.findcateserver.services.FoodService;
import team.j2e8.findcateserver.services.ShopService;
import team.j2e8.findcateserver.services.UserService;

import javax.annotation.Resource;
import java.util.List;

/**
 * @auther vinsonws
 * @date 2018/12/11 21:37
 */
@Controller
@RequestMapping(value = "/shop")
public class ShopController {
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;
    @Autowired
    private UserService userService;
    @Autowired
    private FoodService foodService;
    @Autowired
    private ShopService shopService;

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "getsbyuser")
    public ResponseEntity<?> getShopsByUser(@RequestParam(value = "${spring.data.rest.page-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-number}") Integer pageNum,
                                            @RequestParam(value = "${spring.data.rest.limit-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-size}") Integer pageSize,
                                            @RequestParam(value = "${spring.data.rest.sort-param-name}", required = false, defaultValue = "shopId") String sort) {
        Page<Shop> shops = shopService.getAllShopByUser(sort, pageNum, pageSize);
        return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(shops, "(shopId, shopName, shopTelenumber, shopAddress, shopPhoto, shopLng, shopLat, types(typeId, typeName))"));

    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "getone")
    public ResponseEntity<?> getShopById(@RequestParam(required = true, defaultValue = "") Integer shopId,
                                         @RequestParam(value = "${spring.data.rest.page-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-number}") Integer pageNum,
                                         @RequestParam(value = "${spring.data.rest.limit-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-size}") Integer pageSize,
                                         @RequestParam(value = "${spring.data.rest.sort-param-name}", required = false, defaultValue = "shopId") String sort) {
        Page<Shop> shops = shopService.getShopById(shopId, sort, pageNum, pageSize);
        return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(shops, "(shopId, shopName, shopTelenumber, shopAddress, shopPhoto, shopLng, shopLat, types(typeId, typeName))"));

    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.POST, value = "/open")
    public ResponseEntity<?> openShop(@RequestBody JsonNode jsonNode) throws Exception {
        String password = jsonNode.path("password").textValue();
        String shopName = jsonNode.path("shop_name").textValue();
        String shopAddr = jsonNode.path("shop_addr").textValue();
        String shopTelenumber = jsonNode.path("shop_telenumber").textValue();
        String shopPhoto = jsonNode.path("shop_photo").textValue();
//        String shopLng = jsonNode.path("shop_lng").textValue();
//        String shopLat = jsonNode.path("shop_lat").textValue();
        shopService.registerShop(password, shopName, shopAddr, shopTelenumber, shopPhoto);
        return ResponseEntity.status(HttpStatus.CREATED).body(null);
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "/unactive")
    public ResponseEntity<?> showUnactiveShop() throws Exception {
        Iterable<Shop> shops = shopService.getDisactiveShops();

        return ResponseEntity.ok(new ObjectSelector().mapObjects(shops,
                "(shopId, shopName, shopTelenumber, shopAddress," +
                        " shopPhoto, shopLng, shopLat, types(typeId, typeName))"));
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "/active")
    public ResponseEntity<?> activeShop(@RequestBody JsonNode jsonNode) throws Exception {
        int id = jsonNode.path("id").asInt();
        shopService.activeShop(id);
        return ResponseEntity.status(HttpStatus.CREATED).body(null);
    }

    @ResponseBody
    @RequestMapping(method = RequestMethod.GET, value = "search")
    public ResponseEntity<?> getShopById(@RequestParam(required = true) Double lng,
                            @RequestParam(required = true) Double lat,
                            @RequestParam(required = false) String name,
                            @RequestParam(required = false) String type, Pageable pageable,
                            @RequestParam(value = "${spring.data.rest.page-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-number}") Integer pageNum,
                            @RequestParam(value = "${spring.data.rest.limit-param-name}", required = false, defaultValue = "${spring.data.rest.default-page-size}") Integer pageSize) {
        Page<Shop> shops = shopService.getShopsByCondition(lng, lat, name, type, pageNum, pageSize);
        //return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(shops, "(shopId, shopName, shopTelenumber, shopAddress, shopPhoto, shopLng, shopLat, types(typeId, typeName))"));
        return ResponseEntity.ok(new ObjectSelector().mapPagedObjects(shops,
                "(shopId, shopName, shopTelenumber, shopAddress, shopPhoto, shopLng, shopLat, types(typeId, typeName))"));
    }
}
