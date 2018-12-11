package team.j2e8.findcateserver.services;

import com.querydsl.core.BooleanBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import team.j2e8.findcateserver.exceptions.BusinessException;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.*;
import team.j2e8.findcateserver.repositories.CommityRepository;
import team.j2e8.findcateserver.repositories.ShopRepository;
import team.j2e8.findcateserver.repositories.UserRepository;
import team.j2e8.findcateserver.utils.EnsureDataUtil;
import team.j2e8.findcateserver.utils.HttpResponseDataUtil;
import team.j2e8.findcateserver.valueObjects.ErrorCode;
import team.j2e8.findcateserver.valueObjects.ErrorMessage;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @auther Heyanhu
 * @date 2018/12/11 18:15
 */
@Service
public class CommityService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ShopRepository shopRepository;
    @Autowired
    private CommityRepository commityRepository;
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;

    private QShop qShop = QShop.shop;
    private QCommity qCommity = QCommity.commity;
    public void insertComments (int shopId,String comments)throws Exception{
        EnsureDataUtil.ensureNotEmptyData(comments, ErrorMessage.EMPTY_LOGIN_NAME.getMessage());
        User user = (User) identityContext.getIdentity();
        BooleanBuilder booleanBuilder1 = new BooleanBuilder().and(qShop.shopId.eq(shopId));
        //查询

        Optional<Shop> optionalShop = shopRepository.findOne(booleanBuilder1);
        java.sql.Date date = new java.sql.Date(new Timestamp(System.currentTimeMillis()).getTime());
        Commity commity = new Commity();
        commity.setCommityContent(comments.trim());
        commity.setCommityTime(date);
        commity.setUser(user);
        commity.setShop(optionalShop.get());
        optionalShop.get().getFoods();
        commityRepository.save(commity);
    }

    public Page<Commity> getCommentsByShopId(Integer shopId, String sort, int pageNum, int pageSize){
        if (shopId == null) throw new NullPointerException("需要shopId");
        Optional<Shop> optionalShop = shopRepository.findOne(qShop.shopId.eq(shopId));
        if (!optionalShop.isPresent()) throw new BusinessException(ErrorCode.RESOURCE_NOT_FOUND, ErrorMessage.NOT_FOUND);
        BooleanBuilder booleanBuilder = new BooleanBuilder().and(qCommity.shop.shopId.eq(shopId));

        return commityRepository.findAll(booleanBuilder, HttpResponseDataUtil.sortAndPaging(sort, pageNum, pageSize));
    }
}
