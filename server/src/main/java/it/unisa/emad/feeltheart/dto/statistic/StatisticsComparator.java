package it.unisa.emad.feeltheart.dto.statistic;

import java.util.Comparator;

public class StatisticsComparator implements Comparator<StatisticDto> {

    @Override
    public int compare(StatisticDto o1, StatisticDto o2) {
        if(!o1.getFirst_place().equals(o2.getFirst_place()))
            return - Long.compare(o1.getFirst_place(), o2.getFirst_place());
        else if(!o1.getSecond_place().equals(o2.getSecond_place()))
            return - Long.compare(o1.getSecond_place(), o2.getSecond_place());
        else
            return - Long.compare(o1.getThird_place(), o2.getThird_place());
    }
}
