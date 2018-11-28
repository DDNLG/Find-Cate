package team.j2e8.findcateserver.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import team.j2e8.findcateserver.models.QShop;
import team.j2e8.findcateserver.models.QUser;
import team.j2e8.findcateserver.models.Shop;
import team.j2e8.findcateserver.models.User;
import team.j2e8.findcateserver.repositories.ShopRepository;
import team.j2e8.findcateserver.repositories.UserRepository;

/**
 * @auther vinsonws
 * @date 2018/11/28 22:42
 */
@Controller
@ResponseBody
public class TestController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ShopRepository shopRepository;

    private final QUser qUser = QUser.user;

    private final QShop qShop = QShop.shop;
    @RequestMapping(method = RequestMethod.GET, value = "/test")
    public void test() throws Exception {
        User user = new User();
        user.setId(2);
        user.setUserEmail("adss@qq.com");
        user.setUserName("zwsss");
        user.setUserTelenumber("31231");
        user.setUserPhoto("sadaasasd");
        Shop shop = new Shop();
        shop.setShopAddress("sadsad");
        shop.setShopId(1);
        shop.setUser(user);
        shopRepository.save(shop);
    }
}
