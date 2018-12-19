package team.j2e8.findcateserver.services;

import com.querydsl.core.BooleanBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import team.j2e8.findcateserver.exceptions.BusinessException;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.*;
import team.j2e8.findcateserver.repositories.FoodRepository;
import team.j2e8.findcateserver.repositories.ShopRepository;
import team.j2e8.findcateserver.repositories.TypeRepository;
import team.j2e8.findcateserver.utils.EnsureDataUtil;
import team.j2e8.findcateserver.utils.HttpResponseDataUtil;
import team.j2e8.findcateserver.valueObjects.ErrorCode;
import team.j2e8.findcateserver.valueObjects.ErrorMessage;

import javax.annotation.Resource;
import java.util.Optional;
import java.util.Set;

/**
 * @auther vinsonws
 * @date 2018/12/11 17:42
 */
@Service
public class FoodService {
    @Autowired
    private ShopRepository shopRepository;
    @Autowired
    private TypeRepository typeRepository;
    @Autowired
    private FoodRepository foodRepository;
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;

    private QShop qShop = QShop.shop;
    private QType qType = QType.type;
    private QFood qFood = QFood.food;

    public void shopServeDish(String foodName, int typeId, String foodPhoto, Float foodPrice, int shopId){
        if (typeId == 0 || shopId ==0) throw new NullPointerException("店铺或者类型不为空");
        if (foodName == null || foodPhoto == null || foodPrice == null )
            throw  new NullPointerException("菜名或者菜图或者价格不为空");
        User user = (User) identityContext.getIdentity();
        Optional<Shop> optionalShop = shopRepository.findOne(qShop.shopId.eq(shopId));
        Shop shop = null;
        Type type = null;
        if (optionalShop.isPresent()){
            shop = optionalShop.get();
        } else {
            throw new BusinessException(ErrorCode.RESOURCE_NOT_FOUND, ErrorMessage.NOT_FOUND);
        }
        if (shop.getUser().getId().intValue() != user.getId().intValue()){
            throw new BusinessException(ErrorCode.UNAUTHORIZED_ACCESS, ErrorMessage.ACCOUNT_NOT_EXIST);
        }
        Optional<Type> optionalType = typeRepository.findOne(qType.typeId.eq(typeId));
        if (optionalType.isPresent()){
            type = optionalType.get();
        } else {
            throw new BusinessException(ErrorCode.RESOURCE_NOT_FOUND, ErrorMessage.NOT_FOUND);
        }
        Food food = new Food();
        food.setFoodName(foodName);
        food.setFoodPrice(foodPrice);
        food.setFoodPhoto(foodPhoto);
        food.setType(type);
        food.setShop(shop);
        foodRepository.save(food);
    }

    public void unServeDish(int foodId, int shopId){
        if (foodId == 0 || shopId ==0) throw new NullPointerException("店铺或者菜不为空");
        User user = (User) identityContext.getIdentity();
        Optional<Shop> optionalShop = shopRepository.findOne(qShop.shopId.eq(shopId));
        Shop shop = null;
        Food food = null;
        if (optionalShop.isPresent()){
            shop = optionalShop.get();
        } else {
            throw new BusinessException(ErrorCode.RESOURCE_NOT_FOUND, ErrorMessage.NOT_FOUND);
        }
        if (shop.getUser().getId().intValue() != user.getId().intValue()){
            throw new BusinessException(ErrorCode.UNAUTHORIZED_ACCESS, ErrorMessage.ACCOUNT_NOT_EXIST);
        }
        Optional<Food> optionalFood = foodRepository.findById(foodId);
        if (optionalFood.isPresent()){
            food = optionalFood.get();
        } else {
            throw new BusinessException(ErrorCode.RESOURCE_NOT_FOUND, ErrorMessage.NOT_FOUND);
        }
        foodRepository.delete(food);
    }

    public Page<Food> getFoodsByShop(int shopId, String sort, int pageNum, int pageSize){
        if (shopId ==0) throw new NullPointerException("店铺或者类型不为空");
        BooleanBuilder booleanBuilder = new BooleanBuilder();
        booleanBuilder.and(qFood.shop.shopId.eq(shopId));
        return foodRepository.findAll(booleanBuilder, HttpResponseDataUtil.sortAndPaging(sort, pageNum, pageSize));
    }
}
