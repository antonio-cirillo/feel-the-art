package it.unisa.emad.feeltheart.dto.user;

import it.unisa.emad.feeltheart.dto.statistic.StatisticsComparator;

import java.util.Comparator;

public class UserComparatorByStatistics implements Comparator<UserDto> {

    @Override
    public int compare(UserDto o1, UserDto o2) {
        return new StatisticsComparator().compare(o1.getStatistics(), o2.getStatistics());
    }
}
