package team.j2e8.findcateserver.services;

import com.querydsl.core.BooleanBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team.j2e8.findcateserver.exceptions.ResourceNotFoundException;
import team.j2e8.findcateserver.exceptions.UnAuthorizedException;
import team.j2e8.findcateserver.infrastructure.usercontext.IdentityContext;
import team.j2e8.findcateserver.models.QUser;
import team.j2e8.findcateserver.models.User;
import team.j2e8.findcateserver.repositories.UserRepository;
import team.j2e8.findcateserver.utils.Encryption;
import team.j2e8.findcateserver.utils.EnsureDataUtil;
import team.j2e8.findcateserver.valueObjects.ErrorMessage;

import javax.annotation.Resource;
import java.util.Optional;

/**
 * @auther vinsonws
 * @date 2018/11/30 16:18
 */
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Resource(name = "tokenIdentityContext")
    private IdentityContext identityContext;

    private QUser qUser = QUser.user;

    public User verifyUserByEmail(String email, String password) throws Exception {
        //首先判断是否传递了空值，如果是空值，就丢异常，提醒用户
        EnsureDataUtil.ensureNotEmptyData(email, ErrorMessage.EMPTY_LOGIN_NAME.getMessage());
        //拼接查询语句
        BooleanBuilder booleanBuilder = new BooleanBuilder().and(qUser.userEmail.eq(email.trim()));
        //查询
        Optional<User> optionalUser = userRepository.findOne(booleanBuilder);
        if (!optionalUser.isPresent()) {
            throw new ResourceNotFoundException(ErrorMessage.ACCOUNT_NOT_EXIST);
        }
        return verifyUserByPassword(optionalUser.get(), password, ErrorMessage.ERROR_LOGIN__NAME_OR_PASSWORD.getMessage());
    }

    public void registerUserByEmail(String email, String userName,String userTelenumber,String userPhoto, String password) throws Exception {
        //首先判断是否传递了空值，如果是空值，就丢异常，提醒用户
        EnsureDataUtil.ensureNotEmptyData(email, ErrorMessage.EMPTY_LOGIN_NAME.getMessage());;
        //拼接查询语句
        BooleanBuilder booleanBuilder = new BooleanBuilder().and(qUser.userEmail.eq(email.trim()));
        //查询
        Optional<User> optionalUser = userRepository.findOne(booleanBuilder);
        if (optionalUser.isPresent()) {
            throw new ResourceNotFoundException(ErrorMessage.ENTITY_ALREADY_EXIST);
        }
        User user = new User();
        user.setUserEmail(email);
        user.setUserName(userName);
        user.setUserTelenumber(userTelenumber);
        user.setUserPhoto(userPhoto);
        userRepository.save(parsePasswordWithSalt(user, password));
    }

    private User verifyUserByPassword(User user, String password, String errorMessage) throws Exception {
        EnsureDataUtil.ensureNotEmptyData(password, ErrorMessage.EMPTY_PASSWORD.getMessage());
        Encryption encryption = new Encryption();
        if (user.getUserPassword().equals(encryption.getPassword(password, user.getUserSalt()))) {
            return user;
        } else {
            throw new UnAuthorizedException(errorMessage);
        }
    }

    private User parsePasswordWithSalt(User user, String password) throws Exception {
        EnsureDataUtil.ensureNotEmptyData(password, ErrorMessage.EMPTY_PASSWORD.getMessage());
        Encryption encryption = new Encryption();
        user.setUserSalt(encryption.getSalt());
        user.setUserPassword(encryption.getPassword(password.trim(), user.getUserSalt()));
        return user;
    }
}
