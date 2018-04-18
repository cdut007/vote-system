//package com.itender.ms.mapper;
//
//import org.activiti.engine.HistoryService;
//import org.activiti.engine.RepositoryService;
//import org.activiti.engine.RuntimeService;
//import org.activiti.engine.TaskService;
//import org.activiti.engine.delegate.DelegateExecution;
//import org.activiti.engine.task.Task;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Service("reviewService")
//public class ReviewActivitiService {
//
//    @Autowired
//    private ItenderReviewMapper reviewMapper;
//    @Autowired
//    private RuntimeService runtimeService;
//    @Autowired
//    private TaskService taskService;
//
//    @Autowired
//    private HistoryService historyService;
//
//    @Autowired
//    private  RepositoryService repositoryService;
//    /**
//     * 启动流程
//     *
//     */
//    public void startProcess(String bizKey) {
//        //第一个参数是指定启动流程的id,即要启动哪个流程 ;第二个参数是指业务id
//        System.out.println("启动前-----");
//        runtimeService.startProcessInstanceByKey("leaveProcess", bizKey);
//        System.out.println("启动之后------");
//    }
//
//    /**
//     * 根据审批人id查询需要审批的任务
//     * @param userId
//     * @return
//     */
//    public List<Task> findTaskByUserId(String userId) {
//        List<Task> list = taskService.createTaskQuery().taskCandidateOrAssigned(userId).list();
//        return list;
//    }
//
//    /**
//     * 审批
//     * @param taskId 审批的任务id
//     * @param userId 审批人的id
//     * @param audit  审批意见：通过（pass）or驳回（reject）
//     */
//    public void completeTaskByUser(String taskId,String userId,String audit) {
//        Map<String, Object> map = new HashMap<>();
//        //1、认领任务
//        taskService.claim(taskId, userId);
//        //2.完成任务
//        map.put("audit",audit);
//        taskService.complete(taskId, map);
//    }
//
//    /**
//     * 查询相关经办人
//     * @param execution 执行实例的代理对象 ,代表的是一个请假的具体实例
//     * @return
//     */
//    public List<String> findOperator(DelegateExecution execution) {
//        return Arrays.asList("project1","project2");
//    }
//
//
//
//
//}