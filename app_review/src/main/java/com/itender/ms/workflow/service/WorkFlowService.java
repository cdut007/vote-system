package com.itender.ms.workflow.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.FormService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.Job;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class WorkFlowService implements IWorkFlowService {

    @Resource
    private RuntimeService runtimeService;

    @Resource
    private IdentityService identityService;

    @Resource
    private ManagementService managementService;

    @Resource
    private RepositoryService responsitorySercvie;

    @Resource
    private TaskService taskService;

    @Autowired
    private FormService formService;

    private Logger logger = LoggerFactory.getLogger(WorkFlowService.class);

    @Override
    public void startProcessInstanceByKey(String userId, String processDefinitionKey) {
        this.identityService.setAuthenticatedUserId(userId);
        this.runtimeService.startProcessInstanceByKey(processDefinitionKey);

    }

    @Override
    public void startProcessInstanceByKey(String userId, String processDefinitionKey, String processBusinessKey) {
        this.identityService.setAuthenticatedUserId(userId);
        this.runtimeService.startProcessInstanceByKey(processDefinitionKey, processBusinessKey);
    }

    @Override
    public void startProcessInstanceByKey(String userId, String processDefinitionKey, String processBusinessKey, Map<String, Object> variables) {
        this.identityService.setAuthenticatedUserId(userId);
        this.runtimeService.startProcessInstanceByKey(processDefinitionKey, processBusinessKey, variables);

    }

    @Override
    public void signalEventReceived(String signalName, String executionId) {
        this.runtimeService.signalEventReceived(signalName, executionId);

    }

    @Override
    public void deleteProcessInstance(String processInstanceId, String deleteReason) {
        this.runtimeService.deleteProcessInstance(processInstanceId, deleteReason);
    }



    @Override
    public void executeJob(String jobId){
        this.managementService.executeJob(jobId);
    }



    @Override
    public void deploy(String fileName,InputStream inputStream){
        DeploymentBuilder builder = this.responsitorySercvie.createDeployment();
        builder.addInputStream(fileName, inputStream);
        builder.deploy();
    }

    @Override
    public List<ActivityImpl> getActivityListByProcessInstanceId(String processInstanceId) {
        List<ActivityImpl> activityList =new ArrayList<ActivityImpl>();
        ProcessInstance processInstnace = this.runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        String processDefinitionId=processInstnace.getProcessDefinitionId();
        ProcessDefinitionEntity definitionEntity = (ProcessDefinitionEntity) ((RepositoryServiceImpl) this.responsitorySercvie).getDeployedProcessDefinition(processDefinitionId);
        List<Task> taskList = this.taskService.createTaskQuery().processInstanceId(processInstanceId).list();
        List<ActivityImpl> activities = definitionEntity.getActivities();
        for (Task task : taskList) {
            ExecutionEntity executionEntity = (ExecutionEntity) runtimeService.createExecutionQuery().executionId(task.getExecutionId()).singleResult();
            String activitiId = executionEntity.getActivityId();
            for (ActivityImpl activity1 : activities) {
                if (activity1.getId().equals(activitiId)) {
                    activityList.add(activity1);
                    break;
                }
            }
        }
        return activityList;
    }

    @Override
    public ProcessInstance getProcessInstance(String processInstanceId){
        return this.runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
    }

    public void logWorkFlowInfo(String msg) {
        logger.info(msg);
    }

    @Override
    public void completCurrentUserTask(String processBusinessKey, Map<String, String> formProperties) {

    }


}
