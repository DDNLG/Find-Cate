package team.j2e8.findcateserver.repositories;

import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import team.j2e8.findcateserver.models.Shop;

/**
 * @auther vinsonws
 * @date 2018/11/28 23:03
 */
@Repository
public interface ShopRepository extends PagingAndSortingRepository<Shop, Integer>, QuerydslPredicateExecutor<Shop> {
}
