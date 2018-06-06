package com.itender.ms.evaluation;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class MathTool {
    public  static  boolean greaterThen(Object object1, Object object2) {
        return new BigDecimal(object1.toString()).compareTo(new BigDecimal(object2.toString())) > 0;
    }

    public static boolean lessThen(Object object1, Object object2) {
        return new BigDecimal(object1.toString()).compareTo(new BigDecimal(object2.toString())) < 0;
    }

    public static BigDecimal abs(Object numberObject) {
        return abs(numberObject.toString());
    }

    public static BigDecimal abs(String numberString) {
        return abs(new BigDecimal(numberString));
    }

    public static BigDecimal abs(BigDecimal number) {
        return number.abs();
    }

    public static BigDecimal min(List<BigDecimal> numberObjectList) {
        Collections.sort(numberObjectList);
        return numberObjectList.get(0);
    }

    public static BigDecimal min(Object... numberObjectArray) {
        String[] numberStringArray = new String[numberObjectArray.length];
        for (int i = 0; i < numberObjectArray.length; i++) {
            numberStringArray[i] = numberObjectArray[i].toString();
        }
        return min(numberStringArray);
    }

    public static BigDecimal min(String... numberString) {
        BigDecimal[] bigDecimalArray = new BigDecimal[numberString.length];
        for (int i = 0; i < numberString.length; i++) {
            bigDecimalArray[i] = new BigDecimal(numberString[i]);
        }
        return min(bigDecimalArray);
    }

    public static BigDecimal min(BigDecimal... bigDecimalArray) {
        if (bigDecimalArray.length > 0) {
            Arrays.sort(bigDecimalArray);
            return bigDecimalArray[0];
        } else {
            return null;
        }
    }

    public static BigDecimal max(List<BigDecimal> numberObjectList) {
        Collections.sort(numberObjectList);
        return numberObjectList.get(numberObjectList.size() - 1);
    }

    public static BigDecimal max(Object... numberObjectArray) {
        String[] numberStringArray = new String[numberObjectArray.length];
        for (int i = 0; i < numberObjectArray.length; i++) {
            numberStringArray[i] = numberObjectArray[i].toString();
        }
        return max(numberStringArray);
    }

    public static BigDecimal max(String... numberStringArray) {
        BigDecimal[] bigDecimalArray = new BigDecimal[numberStringArray.length];
        for (int i = 0; i < numberStringArray.length; i++) {
            bigDecimalArray[i] = new BigDecimal(numberStringArray[i]);
        }
        return max(bigDecimalArray);
    }

    public static BigDecimal max(BigDecimal... bigDecimalArray) {
        if (bigDecimalArray.length > 0) {
            Arrays.sort(bigDecimalArray);
            return bigDecimalArray[bigDecimalArray.length - 1];
        } else {
            return null;
        }
    }

	/*public BigDecimal max(BigDecimal bigDecimalArray1,BigDecimal bigDecimalArray2) {
		return	bigDecimalArray1.compareTo(bigDecimalArray2)>0?bigDecimalArray2:bigDecimalArray1;
	}

	public BigDecimal min(BigDecimal bigDecimalArray1,BigDecimal bigDecimalArray2) {
		return	bigDecimalArray1.compareTo(bigDecimalArray2)<0?bigDecimalArray2:bigDecimalArray1;
	}*/

    public static BigDecimal avg(List<Object> numberObjectList) {
        BigDecimal sum = sum(numberObjectList);
        return sum.divide(new BigDecimal(numberObjectList.size()), 9, BigDecimal.ROUND_HALF_DOWN);
    }

    public static BigDecimal avgBigDecimal(List<BigDecimal> numberObjectList) {
        BigDecimal sum = sumBigDecimal(numberObjectList);
        return sum.divide(new BigDecimal(numberObjectList.size()), 9, BigDecimal.ROUND_HALF_DOWN);
    }

    public static BigDecimal avg1(List<BigDecimal> numberObjectList) {
        BigDecimal sum=new BigDecimal(0);
        for(int i=0;i<numberObjectList.size();i++){
            sum=sum.add(numberObjectList.get(i));
        }
        return sum.divide(new BigDecimal(numberObjectList.size()),9,BigDecimal.ROUND_UP);
    }

    public static BigDecimal avg2(List<BigDecimal> numberObjectList) {
        BigDecimal sum=new BigDecimal(0);
        for(int i=0;i<numberObjectList.size();i++){
            sum=sum.add(numberObjectList.get(i));
        }
        return sum.divide(new BigDecimal(numberObjectList.size()),9,BigDecimal.ROUND_UP);
    }

    public static int[] randomInts(int min, int max, int n){
        if (n > (max - min + 1) || max < min) {
            return null;
        }
        int[] result = new int[n];
        int count = 0;
        while(count < n) {
            int num = (int) (Math.random() * (max - min)) + min;
            boolean flag = true;
            for (int j = 0; j < n; j++) {
                if(num == result[j]){
                    flag = false;
                    break;
                }
            }
            if(flag){
                result[count] = num;
                count++;
            }
        }
        return result;
    }


    public static BigDecimal sum(List<Object> numberObjectList) {
        BigDecimal sum = new BigDecimal(0);
        for (int i = 0; i < numberObjectList.size(); i++) {
            sum = sum.add(new BigDecimal(numberObjectList.get(i).toString()));
        }
        return sum;
    }

    public static BigDecimal sumBigDecimal(List<BigDecimal> numberObjectList) {
        BigDecimal sum = new BigDecimal(0);
        for (int i = 0; i < numberObjectList.size(); i++) {
            sum = sum.add(numberObjectList.get(i));
        }
        return sum;
    }



    //平均价格，5家平均家报价得分算法
    public static Float countScore1(BigDecimal PRICE, BigDecimal BENCHMARK, Object GT_SCORE, Object GT_MIN_SCORE,
                             Object GT_PERCENT, Object LT_SCORE, Object LT_MIN_SCORE, Object LT_PERCENT, Object FULL_SCORE) {
        Float score = Float.parseFloat(FULL_SCORE.toString());

        if (PRICE.compareTo(BENCHMARK) > 0) {
            score = countScore1(PRICE, BENCHMARK, GT_SCORE, GT_MIN_SCORE, GT_PERCENT, FULL_SCORE);
        } else if (PRICE.compareTo(BENCHMARK) < 0) {
            score = countScore1(PRICE, BENCHMARK, LT_SCORE, LT_MIN_SCORE, LT_PERCENT, FULL_SCORE);
        }

        return score;
    }

    // 交通合理低价法
    public static Float countScoreWithJTHLDJ(BigDecimal PRICE, BigDecimal BENCHMARK, Object GT_SCORE, Object GT_MIN_SCORE,
                                      Object GT_PERCENT, Object LT_SCORE, Object LT_MIN_SCORE, Object LT_PERCENT, Object FULL_SCORE) {
        Float score = Float.parseFloat(FULL_SCORE.toString());

        if (PRICE.compareTo(BENCHMARK) > 0) {
            score = countScore1(PRICE, BENCHMARK, GT_SCORE, GT_MIN_SCORE, GT_PERCENT, FULL_SCORE);
        } else if (PRICE.compareTo(BENCHMARK) < 0) {
            score = countScore1(PRICE, BENCHMARK, LT_SCORE, LT_MIN_SCORE, LT_PERCENT, FULL_SCORE);
        }

        return score;
    }


    private static Float countScore1(BigDecimal PRICE, BigDecimal BENCHMARK, Object SCORE, Object MIN_SCORE, Object PERCENT, Object FULL_SCORE) {

        Float each_score = Float.parseFloat(SCORE.toString());
        Float min_score = Float.parseFloat(MIN_SCORE.toString());
        Float percent = Float.parseFloat(PERCENT.toString());
        Float full_score = Float.parseFloat(FULL_SCORE.toString());

        Float result_score = full_score;

        BigDecimal multiply = BENCHMARK.multiply(new BigDecimal(percent / 100).setScale(9,BigDecimal.ROUND_HALF_UP));
        BigDecimal gap = new BigDecimal(0d);
        if(PRICE.compareTo(BENCHMARK) > 0) {
            gap = (PRICE.subtract(BENCHMARK));
        }else {
            gap = (BENCHMARK.subtract(PRICE));
        }

        BigDecimal gapLength = gap.divide(multiply, 9, RoundingMode.HALF_UP);// 这里保留3位小数其实已经可以了，但是each_score参数如果是5,最后的result_score计算结果就会出现只有2位的情况，造成交通没有保留3位小数的误解
        if(full_score==10f){
            result_score = (float) (100f - gapLength.doubleValue() * each_score)/10;
        }else{
            result_score = (float) (full_score - gapLength.doubleValue() * each_score);
        }

        if (result_score < min_score) {
            result_score = min_score;
        }
        Float f = new BigDecimal(result_score).setScale(9,BigDecimal.ROUND_HALF_UP).floatValue();
        return f;

    }

    public static Float countScore2(BigDecimal PRICE, BigDecimal BENCHMARK, Object GT_SCORE, Object GT_MIN_SCORE,
                             Object GT_PERCENT, Object LT_SCORE, Object LT_MIN_SCORE, Object LT_PERCENT, Object FULL_SCORE) {
        Float score = Float.parseFloat(FULL_SCORE.toString());

        if (PRICE.compareTo(BENCHMARK) > 0) {
            score = countScore2(PRICE, BENCHMARK, GT_SCORE, GT_MIN_SCORE, GT_PERCENT, FULL_SCORE);
        } else if (PRICE.compareTo(BENCHMARK) < 0) {
            score = countScore2(PRICE, BENCHMARK, LT_SCORE, LT_MIN_SCORE, LT_PERCENT, FULL_SCORE);
        }

        return score;
    }
    private static Float countScore2(BigDecimal PRICE, BigDecimal BENCHMARK, Object SCORE, Object MIN_MAX_SCORE, Object PERCENT, Object FULL_SCORE) {

        Float each_score = Float.parseFloat(SCORE.toString());
        Float min_max_score = Float.parseFloat(MIN_MAX_SCORE.toString());
        Float percent = Float.parseFloat(PERCENT.toString());
        Float full_score = Float.parseFloat(FULL_SCORE.toString());

        Float result_score = full_score;
        BigDecimal checkPrice = PRICE;
        BigDecimal subtractScore = BENCHMARK.multiply(new BigDecimal((float) percent / 100));
        BigDecimal addScore = BENCHMARK.multiply(new BigDecimal((float) percent / 100));

        boolean add = true;
        if (PRICE.compareTo(BENCHMARK) > 0) {
            add = false;
        }
        while (true) {
            if (add) {
                checkPrice = checkPrice.add(addScore);
            } else {
                checkPrice = checkPrice.subtract(subtractScore);
            }

            if (add && result_score > min_max_score) {
                result_score = min_max_score;
                break;
            }

            if (!add && result_score <= min_max_score) {
                result_score = min_max_score;
                break;
            }
            if ((add && checkPrice.compareTo(BENCHMARK) < 0)){
                result_score+= each_score;
            }else if (!add && checkPrice.compareTo(BENCHMARK) > 0) {
                result_score -= each_score;
            } else {
                break;
            }
        }

        if (add && result_score > min_max_score) {
            result_score = min_max_score;
        }

        if (!add && result_score <= min_max_score) {
            result_score = min_max_score;
        }
        return result_score;
    }

    //系统设置的最低价报价计算方法
    public static Float countScore3(BigDecimal PRICE, BigDecimal BENCHMARK, Object GT_SCORE, Object GT_MIN_SCORE,
                             Object GT_PERCENT, Object FULL_SCORE) {
        Float gt_score = Float.parseFloat(GT_SCORE.toString());
        Float full_score = Float.parseFloat(FULL_SCORE.toString());
        Float gt_min_score = Float.parseFloat(GT_MIN_SCORE.toString());
        Float gt_percent = Float.parseFloat(GT_PERCENT.toString());
        Float result_score = full_score;

        BigDecimal multiply = BENCHMARK.multiply(new BigDecimal(gt_percent / 100).setScale(9,BigDecimal.ROUND_HALF_UP));

        BigDecimal gap = (PRICE.subtract(BENCHMARK));


        BigDecimal gapLength = gap.divide(multiply, 9, RoundingMode.HALF_UP);
        result_score = (float) (full_score - gapLength.doubleValue() * gt_score);


        if (result_score < gt_min_score) {
            result_score = gt_min_score;
        }

        return new BigDecimal(result_score).setScale(9,BigDecimal.ROUND_HALF_UP).floatValue();
        //return result_score;
    }

    public static float computeBenchmark(List<BigDecimal> priceList,float floatRate){
        List<BigDecimal> priceList1;
        int size=priceList.size();
        //确定基准价合成范围
        if(size>5){
            Collections.sort(priceList);
            int count=(int)Math.round(size*0.2);
            int start=count;
            int end=size-count-1;
            priceList1=new ArrayList<BigDecimal>();
            for(int i=start;i<=end;i++){
                priceList1.add(priceList.get(i));
            }
        }else{
            priceList1=priceList;
        }
        //计算合理最低价
        BigDecimal avgPrice=avg1(priceList1);
        avgPrice=avgPrice.multiply(new BigDecimal(1-floatRate/100));

        //去掉低于合理最低价的报价
        List<BigDecimal> priceList2=new ArrayList<BigDecimal>();
        for(int i=0;i<priceList1.size();i++){
            if(priceList1.get(i).compareTo(avgPrice)<0) continue;
            priceList2.add(priceList1.get(i));
        }

        //随机抽取9家投标报价
        List<BigDecimal> priceList3;
        if(priceList2.size()>9){
            priceList3=new ArrayList<BigDecimal>();
            int[] indexes=randomInts(0,priceList2.size(),9);
            for(int i=0;i<indexes.length;i++){
                priceList3.add(priceList2.get(indexes[i]));
            }
        }else{
            priceList3=priceList2;
        }

        //去掉最高价和最低价
        Collections.sort(priceList3);
        if(priceList3.size()>=3){
            priceList3.remove(0);
            priceList3.remove(priceList3.size()-1);
        }

        //计算评标基准价
        BigDecimal benchmark=avg1(priceList3);
        priceList1=priceList2=priceList3=null;
        return benchmark.floatValue();
    }

    public static float computePrice(float benchmark,float price,float priceScore){
        float delta=Math.abs((price-benchmark)/benchmark);
        float score=priceScore-delta*100;
        if(score<0) score=0;
        return score;
    }

    //市政监理
    public static float computeBenchmark1(List<BigDecimal> priceList){
        Collections.sort(priceList);
        priceList.remove(0);
        priceList.remove(priceList.size()-1);
        BigDecimal benchmark=avg1(priceList);
        return benchmark.floatValue();
    }

    //市政勘察合成底价
    public static float computeBenchmark2(List<BigDecimal> priceList,BigDecimal controlPrice,String weight){
        Collections.sort(priceList);
        priceList.remove(0);
        priceList.remove(priceList.size()-1);
        BigDecimal avgPrice=avg1(priceList);
        String[] weights=weight.split("[/]");
        float rate1=Float.valueOf(weights[0]);
        float rate2=Float.valueOf(weights[1]);
        BigDecimal benchmark=controlPrice.multiply(new BigDecimal(rate1/(rate1+rate2))).
                add(avgPrice.multiply(new BigDecimal(rate2/(rate1+rate2))));
        return benchmark.floatValue();
    }

    //市政勘察计算报价
    public static Float computePrice1(BigDecimal PRICE, BigDecimal BENCHMARK, Object BIAS_RATE,Object GT_SCORE,
                               Object GT_PERCENT, Object FULL_SCORE) {
        return computePrice2(PRICE,BENCHMARK,BIAS_RATE,GT_SCORE,GT_PERCENT,GT_SCORE,GT_PERCENT,FULL_SCORE);
    }

    public static Float computePrice2(BigDecimal PRICE, BigDecimal BENCHMARK, Object BIAS_RATE,Object GT_SCORE,
                               Object GT_PERCENT, Object LT_SCORE,  Object LT_PERCENT, Object FULL_SCORE) {
        Float biasRate=Float.valueOf(BIAS_RATE.toString());
        Float gtScore=Float.valueOf(GT_SCORE.toString());
        Float gtPercent=Float.valueOf(GT_PERCENT.toString());
        Float ltScore=Float.valueOf(LT_SCORE.toString());
        Float ltPercent=Float.valueOf(LT_PERCENT.toString());
        Float fullScore=Float.valueOf(FULL_SCORE.toString());

        BigDecimal lowLimit=BENCHMARK.multiply(new BigDecimal(1-biasRate/100));
        if(PRICE.compareTo(BENCHMARK)<=0&&PRICE.compareTo(lowLimit)>0) return fullScore;

        if(PRICE.compareTo(BENCHMARK)>0){
            float delta=PRICE.floatValue()-BENCHMARK.floatValue();
            float rate=delta*100/(BENCHMARK.floatValue()*gtPercent);
            int rateInt=(int)Math.ceil(rate);
            float discountScore=rateInt*gtScore;
            if(discountScore>=fullScore) return 0f;
            return fullScore-discountScore;
        }else{
            float delta=lowLimit.floatValue()-PRICE.floatValue();
            float rate=delta*100/(lowLimit.floatValue()*ltPercent);
            int rateInt=(int)Math.ceil(rate);
            float discountScore=rateInt*ltScore;
            if(discountScore>=fullScore) return 0f;
            return fullScore-discountScore;
        }
    }

    public static float computeBenchmark3(List<BigDecimal> priceList,float floatRate){
        List<BigDecimal> priceList1;
        int size=priceList.size();
        //确定基准价合成范围
        if(size>5){
            Collections.sort(priceList);
            int count=(int)Math.round(size*0.2);
            int start=count;
            int end=size-count-1;
            priceList1=new ArrayList<BigDecimal>();
            for(int i=start;i<=end;i++){
                priceList1.add(priceList.get(i));
            }
        }else{
            priceList1=priceList;
        }
        //计算合理最低价
        BigDecimal avgPrice=avg1(priceList1);
        avgPrice=avgPrice.multiply(new BigDecimal(1-floatRate/100));
        return avgPrice.floatValue();
    }


    //交通-施工-评标基准价1
    public static float JT_SG_BMK_1(float controlPrice, float avgPrice, float jt_benchmark_1_control_price_ratio,
                             float jt_benchmark_1_add_right_ratio, float jt_benchmark_1_benchmark_ratio) {

        return (controlPrice * (1 - jt_benchmark_1_control_price_ratio/100) * jt_benchmark_1_add_right_ratio
                + avgPrice * (1 - jt_benchmark_1_add_right_ratio)) * jt_benchmark_1_benchmark_ratio;
    }

    //交通-施工-评标基准价1
    public static BigDecimal JT_SG_BMK_1_BIGDECIMAL(BigDecimal controlPrice, BigDecimal avgPrice, BigDecimal jt_benchmark_1_control_price_ratio,
                                             BigDecimal jt_benchmark_1_add_right_ratio, BigDecimal jt_benchmark_1_benchmark_ratio) {

        BigDecimal b1 = new BigDecimal(1).subtract(jt_benchmark_1_control_price_ratio.divide(new BigDecimal(100)));
        BigDecimal b2 = new BigDecimal(1).subtract(jt_benchmark_1_add_right_ratio);
        BigDecimal b = ((controlPrice.multiply(b1).multiply(jt_benchmark_1_add_right_ratio)).add(avgPrice.multiply(b2))).multiply(jt_benchmark_1_benchmark_ratio);
        return b;
    }

    public static void main(String[] args) {


		BigDecimal BENCHMARK = new BigDecimal(9000);

		System.out.println(countScore1(new BigDecimal(8820), BENCHMARK, 1, 20, 1, 2, 20, 1, 40));
		System.out.println(countScore1(new BigDecimal(9900), BENCHMARK, 1, 20, 1, 2, 20, 1, 40));
		System.out.println(countScore1(new BigDecimal(9910), BENCHMARK, 1, 20, 1, 2, 20, 1, 40));
		System.out.println(countScore1(new BigDecimal(10890), BENCHMARK, 1, 20, 1, 2, 20, 1, 40));

		System.out.println(countScore3(new BigDecimal(9000), BENCHMARK, 1, 10, 1, 40));
		System.out.println(countScore3(new BigDecimal(9900), BENCHMARK, 1, 10, 1, 40));

		System.out.println(countScore3(new BigDecimal(10900), BENCHMARK, 1, 10, 1, 40));
		System.out.println(countScore3(new BigDecimal(20900), BENCHMARK, 1, 10, 1, 40));


    }

    public static float getFormatValue(float value, int scale) {

        BigDecimal   step   =   new   BigDecimal(value);


        return  getFormatValue(step,scale).floatValue();
    }

    public static BigDecimal getFormatValue(BigDecimal value, int scale) {

        BigDecimal result = value.setScale(scale,   BigDecimal.ROUND_HALF_UP);

        return  result;
    }
}
