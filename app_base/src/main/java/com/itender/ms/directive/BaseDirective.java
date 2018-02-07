package com.itender.ms.directive;

import com.github.pagehelper.Page;
import com.itender.ms.util.CommonUtility;
import freemarker.core.Environment;
import freemarker.template.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * 当前位置标签
 *
 * @author jiepeng
 */
public abstract class BaseDirective<T> implements TemplateDirectiveModel {
    /**
     * Logger for this class
     */
    private static final Logger logger = LoggerFactory.getLogger(BaseDirective.class);

    private static final ObjectWrapper DEFAULT_WRAPER = WrappingTemplateModel
            .getDefaultObjectWrapper();
    protected static boolean pageable = true;
    protected static final Integer DEFAULT_PAGE_NUMBER = 1;
    protected static final Integer DEFAULT_PAGE_SIZE = 10;
    public static final String TYPE_LIST = "list";
    public static final String TYPE_TREE = "tree";
    public static final String TYPE_COUNT = "count";
    public static final String TYPE_FIELD = "field";

    @SuppressWarnings("rawtypes")
    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars,
                        TemplateDirectiveBody body) throws TemplateException, IOException {

        Map<String, Object> envParams = new HashMap<String, Object>();

        // 查询类型
        String queryType = FreemarkerTemplateUtility.getStringValueFromParams(
                params, "queryType");
        queryType = CommonUtility.isNonEmpty(queryType) ? queryType
                : TYPE_FIELD;
        logger.debug("[queryType] ==> " + queryType);

        // 用户sort信息
        String sort = FreemarkerTemplateUtility.getStringValueFromParams(
                params, "sort");
        logger.debug("[sort] ==> " + sort);

        // 用户order信息
        String order = FreemarkerTemplateUtility.getStringValueFromParams(
                params, "order");
        logger.debug("[order] ==> " + order);

//        // 是否分页
//        Integer pageableInt = FreemarkerTemplateUtility.getIntValueFromParams(
//                params, "pageable");
//        pageable = pageableInt != null && pageableInt == 0 ? false : true;
//        logger.debug("[pageable] ==> " + pageable);
//
//        //若分页则封装分页数据
//        Page<T> pager = new Page<T>();
//        if (pageable) {
//            // 获取页数
//            Integer pageNum = FreemarkerTemplateUtility.getIntValueFromParams(
//                    params, "pageNum");
//            pageNum = pageNum == null ? DEFAULT_PAGE_NUMBER : pageNum;
//            logger.debug("[pageNum] ==> " + pageNum);
//
//            // 每页大小
//            Integer pagesize = FreemarkerTemplateUtility.getIntValueFromParams(
//                    params, "pagesize");
//            pagesize = pagesize == null ? DEFAULT_PAGE_SIZE : pagesize;
//            logger.debug("[pagesize] ==> " + pagesize);
//
//            pager.setPageNum(pageNum);
//            pager.setPagesize(pagesize);
//        }


        // #########################################################
        // 若是FIELD查询条件
        // #########################################################
        if (TYPE_FIELD.equals(queryType)) {
            T val = field(params, envParams);
            if (val != null) {
                validLoopVars(loopVars);
                loopVars[0] = DEFAULT_WRAPER.wrap(val);
            }
            envVariable(env, DEFAULT_WRAPER, envParams);
            if (body != null) {
                body.render(env.getOut());
            }
            return;
        }

        // #########################################################
        // 若是COUNT查询条件
        // #########################################################
        if (TYPE_COUNT.equals(queryType)) {
            Integer val = count(params, envParams);
            if (val != null) {
                validLoopVars(loopVars);
                loopVars[0] = DEFAULT_WRAPER.wrap(val);
            }
            envVariable(env, DEFAULT_WRAPER, envParams);
            if (body != null) {
                body.render(env.getOut());
            }
            return;
        }

        // #########################################################
        // 若是LIST查询条件
        // #########################################################
//        if (TYPE_LIST.equals(queryType)) {
//            String filter = FreemarkerTemplateUtility.getStringValueFromParams(
//                    params, "filter");
//            logger.debug("[filter] ==> " + filter);
//            List<T> list = list(params, filter, order, sort,
//                    pageable, pager, envParams);
//
//            if (list != null) {
//                validLoopVars(loopVars);
//                loopVars[0] = DEFAULT_WRAPER.wrap(list);
//            }
////            if (pageable) {
////                pageVariable(env, pager, DEFAULT_WRAPER);
////            }
//
//            envVariable(env, DEFAULT_WRAPER, envParams);
//            if (body != null) {
//                body.render(env.getOut());
//            }
//            return;
//        }

        // #########################################################
        // 类型为TREE，则查找树形结构数据
        // #########################################################
//        if (TYPE_TREE.equals(queryType)) {
//            List<T> list = tree(params, envParams);
//            if (list != null) {
//                validLoopVars(loopVars);
//                loopVars[0] = DEFAULT_WRAPER.wrap(list);
//            }
//            envVariable(env, DEFAULT_WRAPER, envParams);
//            if (body != null) {
//                body.render(env.getOut());
//            }
//            return;
//        }

    }

//    /**
//     * 设置分页变量到输出环境
//     *
//     * @param env
//     * @param page
//     * @param DEFAULT_WRAPER
//     * @throws TemplateModelException
//     */
//    private static <T> void pageVariable(Environment env, Page<T> page, ObjectWrapper DEFAULT_WRAPER)
//            throws TemplateModelException {
//        env.setVariable("count", DEFAULT_WRAPER.wrap(page.getTotalCounts())); // 总记录数
//        env.setVariable("pagesize", DEFAULT_WRAPER.wrap(page.getPagesize())); // 页面大小
//        env.setVariable("start", DEFAULT_WRAPER.wrap(page.getStartPage())); // 开始页面
//        env.setVariable("end", DEFAULT_WRAPER.wrap(page.getEndPage())); // 结束页面
//        env.setVariable("current", DEFAULT_WRAPER.wrap(page.getCurrentPage())); // 当前页面
//        env.setVariable("pagecount", DEFAULT_WRAPER.wrap(page.getPageCount())); // 页面总数
//    }

    private static void envVariable(Environment env, ObjectWrapper DEFAULT_WRAPER, Map<String, Object> envParams)
            throws TemplateModelException {
        if (envParams != null && envParams.size() > 0) {
            Iterator<Entry<String, Object>> iterator = envParams.entrySet().iterator();
            while (iterator.hasNext()) {
                Entry<String, Object> entry = iterator.next();
                env.setVariable(entry.getKey(), DEFAULT_WRAPER.wrap(entry.getValue()));
            }
        }
    }

    private static void validLoopVars(TemplateModel[] loopVars) {
        if (loopVars.length < 1) {
            throw new RuntimeException("Loop variable is required.");
        }
    }

    /**
     * 统计数量
     *
     * @param params    参数MAP
     * @param envParams 环境变量
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected abstract Integer count(Map params, Map<String, Object> envParams);

    /**
     * 根据字段查找
     *
     * @param params    参数MAP
     * @param envParams 环境变量
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected abstract T field(Map params, Map<String, Object> envParams);

    /**
     * 查找列表
     *
     * @param params    参数MAP
     * @param filter    过滤条件，JSON字符串
     * @param order     排序
     * @param sort      生降序
     * @param pageable  是否分页
     * @param pager     分页对象
     * @param envParams 环境变量
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected abstract List<T> list(Map params, String filter, String order, String sort,
                                    boolean pageable, Page<T> pager, Map<String, Object> envParams);

    /**
     * 查找树形列表
     *
     * @param params    参数
     * @param envParams 环境变量
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected abstract List<T> tree(Map params, Map<String, Object> envParams);

}
