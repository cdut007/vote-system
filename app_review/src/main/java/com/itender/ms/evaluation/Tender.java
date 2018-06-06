package com.itender.ms.evaluation;

import java.math.BigDecimal;

public class Tender implements Comparable<Tender> {



    @Override
    public int compareTo(Tender o) {
        return price.compareTo(o.price);
    }

    private  boolean kickout;



    private float score;

    private float deviationValue;


    private String id;

    private BigDecimal price;

    public void setKickout(boolean kickout) {
        this.kickout = kickout;
    }

    public boolean isKickout() {
        return kickout;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }


    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public float getDeviationValue() {
        return deviationValue;
    }

    public void setDeviationValue(float deviationValue) {
        this.deviationValue = deviationValue;
    }

    @Override
    public String toString() {
        return "Tender{" +
                "kickout=" + kickout +
                ", score=" + score +
                ", deviationValue=" + deviationValue +
                ", id='" + id + '\'' +
                ", price=" + price +
                '}';
    }
}
