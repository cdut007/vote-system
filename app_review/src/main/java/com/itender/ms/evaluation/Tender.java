package com.itender.ms.evaluation;

import java.math.BigDecimal;

public class Tender implements Comparable<Tender> {



    @Override
    public int compareTo(Tender o) {
        return price.compareTo(o.price);
    }

    private  boolean kickout;


    private boolean selected;

    private float score;

    private float skillScore;

    private float creditScore;

    private float deviationValue;


    private String id;

    private BigDecimal price;

    private String tag;

    public Tender setTag(String tag){
        this.tag = tag;
        return this;
    }

    public String getTag() {
        return tag;
    }

    public float getSkillScore() {
        return skillScore;
    }

    public void setSkillScore(float skillScore) {
        this.skillScore = skillScore;
    }

    public float getCreditScore() {
        return creditScore;
    }

    public void setCreditScore(float creditScore) {
        this.creditScore = creditScore;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

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
                ", selected=" + selected +
                ", score=" + score +
                ", skillScore=" + skillScore +
                ", creditScore=" + creditScore +
                ", deviationValue=" + deviationValue +
                ", id='" + id + '\'' +
                ", price=" + price +
                ", tag='" + tag + '\'' +
                '}';
    }
}
