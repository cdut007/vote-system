package com.itender.ms.controller;

import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.*;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.service.ItenderUserService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.ViewUtil;
import com.itextpdf.text.pdf.BaseFont;
import fr.opensagres.xdocreport.itext.extension.font.IFontProvider;
import fr.opensagres.xdocreport.itext.extension.font.ITextFontRegistry;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.*;
import java.net.URL;
import java.util.*;
import java.util.List;

@Api(description = "审批管理模块接口")
@Validated
@Controller
@RequestMapping("/review")
public class ReviewController {
	 private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ItenderReviewService itenderReviewService;


    @Autowired
    private ItenderUserService itenderUserService;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }

    @ApiIgnore
    @RequestMapping("/review")
    public String review(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }


    @ApiIgnore
    @RequestMapping(value = "",method = RequestMethod.GET)
    public String reviewPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_main");
    }



    @ApiIgnore
    @RequestMapping(value = "/review_all_list",method = RequestMethod.GET)
    public String reviewAllListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_all_list");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_list",method = RequestMethod.GET)
    public String reviewListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_list");
    }

    @ApiIgnore
    @RequestMapping(value = "/review_sign",method = RequestMethod.GET)
    public String reviewSignPage(HttpServletRequest request, HttpServletResponse response){
        String confirmId = request.getParameter("confirmId");
        request.setAttribute("confirmId",confirmId);
        return ViewUtil.forward("/review/review_sign");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_all_detail",method = RequestMethod.GET)
    public String reviewAllDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_all_detail");
    }

    @ApiIgnore
    @RequestMapping(value = "/review_detail",method = RequestMethod.GET)
    public String reviewDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_detail");
    }


    @ApiOperation(value = "审批文件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/confirms",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> confirms(HttpServletRequest request,
                                                    @RequestParam(required = false) String id
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            result.put("msg", "用户不存在，查询审批失败！");
            return ResponseEntity.ok(result);
        }
        itenderReviewService.setCurrentUser(user);
        ItenderReview review = itenderReviewService.findById(id);

        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getConfirms());

        return ResponseEntity.ok(result);

   }

    @ApiOperation(value = "审批文件附件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/attaches",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> attachs(HttpServletRequest request,
                                                       @RequestParam(required = false) String id
    ) throws APIException{

        ItenderReview review = itenderReviewService.findById(id);
        Map<String,Object> result = new HashMap<>();
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getAttaches());

        return ResponseEntity.ok(result);

    }



    @ApiOperation(value = "审批列表接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/listReview",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> reviewAll(HttpServletRequest request,
                                                       @RequestParam(required = false) Integer pageNum,
                                                       @RequestParam(required = false) Integer pagesize,
                                                    @RequestParam(required = false) String keyword,
                                                    @RequestParam(required = false) boolean all
    ) throws APIException{
        ItenderUser user=null ;
        if(!all){
             user = (ItenderUser)request.getSession().getAttribute("user");

            if(user == null){
                return ResponseEntity.ok(PageDataConvert.convertToLayuiData(new PageInfo(),200,"success"));
            }
        }


        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderReview> page = null;
        itenderReviewService.setCurrentUser(user);
        itenderReviewService.setSearchInfo(keyword);
        page = itenderReviewService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addReviewPage(HttpServletRequest request,HttpServletResponse response){

        return ViewUtil.forward("review/review_add");
    }


    @ApiIgnore
    @RequestMapping(value = "/choose_operator_page",method = RequestMethod.GET)
    public String chooseOperatorPage(HttpServletRequest request,HttpServletResponse response){
        String operator = request.getParameter("operator");
        String id = request.getParameter("id");
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);
        request.setAttribute("id",id);
        request.setAttribute("itenderUsers",itenderUsers);
        return ViewUtil.forward("review/choose_operator");
    }


    @ApiIgnore
    @RequestMapping(value = "/edit_page",method = RequestMethod.GET)
    public String editReviewPage(HttpServletRequest request,HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }
        request.setAttribute("itenderReview",review);
        return ViewUtil.forward("review/review_edit");
    }


    public static boolean isLinux(String OS){
        return OS.indexOf("linux")>=0;
    }

    public static boolean isMacOS(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")<0;
    }

    public static boolean isMacOSX(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")>0;
    }

    public static boolean isWindows(String OS){
        return OS.indexOf("windows")>=0;
    }

    @RequestMapping(value = "/getSignFile", method = RequestMethod.GET)
    public void getSignFile(HttpServletRequest request,HttpServletResponse res) throws Exception{


        File file = ResourceUtils.getFile("classpath:static/aip/用印登记表.docx");
        Map<String, String> datas = new HashMap<String, String>();

        String confirmId = request.getParameter("confirmId");

        ItenderConfirm itenderConfirm = itenderReviewService.findConfirmsByConfirmId(confirmId);

        if(itenderConfirm == null){
            throw new Exception("confirm file not find");
        }

        datas.put("${projectName}", itenderConfirm.getName());
        datas.put("${count}",itenderConfirm.getCount());
        String exportFile = getFileDirByName("review_files")+itenderConfirm.getName()+".docx";
       boolean result = readwriteWord(file,datas,exportFile);
        if(result){
            XWPFDocument document = new XWPFDocument(new FileInputStream(new File(exportFile)));

            PdfOptions options = PdfOptions.create();

            //中文字体处理
            options.fontProvider(new IFontProvider() {
                public com.lowagie.text.Font getFont(String familyName, String encoding, float size, int style, Color color) {
                    try {
                        String path = getFileDirByName("review_files")+File.separator+ "fonts"+File.separator+"wei_yah.ttf";

                        com.lowagie.text.pdf.BaseFont bfChinese =
                                com.lowagie.text.pdf.BaseFont.createFont(path, BaseFont.IDENTITY_H, BaseFont.EMBEDDED );
                        com.lowagie.text.Font fontChinese = new com.lowagie.text.Font(bfChinese);
                        if (familyName != null)
                            fontChinese.setFamily(familyName);
                        return fontChinese;
                    } catch (Exception e) {
                        e.printStackTrace();
                        return null;
                    }
                }
            });
            //为输出文件创建目录
            //更改word内容并修改为pdf
            String fileName = itenderConfirm.getName()+".pdf";
            File outFile = new File(getFileDirByName("review_files")+fileName);
            outFile.getParentFile().mkdirs();
            PdfConverter.getInstance().convert(document, new FileOutputStream(outFile), options);


            document.close();


            //covert pdf.


            res.setHeader("content-type", "application/octet-stream");
            res.setContentType("application/octet-stream");
            res.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            byte[] buff = new byte[1024];
            BufferedInputStream bis = null;
            OutputStream os = null;
            try {
                os = res.getOutputStream();
                bis = new BufferedInputStream(new FileInputStream(outFile));
                int i = bis.read(buff);
                while (i != -1) {
                    os.write(buff, 0, buff.length);
                    os.flush();
                    i = bis.read(buff);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }


}


    /**
     * 实现对word读取和修改操作
     * @param sourceFile    word模板路径和名称
     * @param map        待填充的数据，从数据库读取
     */
    public static boolean readwriteWord(File sourceFile, Map<String,String> map, String exportFile){
        //读取word模板
//        String fileDir = new File(base.getFile(),"http://www.cnblogs.com/http://www.cnblogs.com/../doc/").getCanonicalPath();
        FileInputStream in = null;
        try {
            in = new FileInputStream(sourceFile);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
            return  false;
        }
        XWPFDocument document = null;
        try {
            document = new XWPFDocument(in);
        } catch (IOException e1) {
            e1.printStackTrace();
            return  false;
        }

        // 替换段落中的指定文字
        Iterator<XWPFParagraph> itPara = document.getParagraphsIterator();
        while (itPara.hasNext()) {
            XWPFParagraph paragraph = (XWPFParagraph) itPara.next();
            //String s = paragraph.getParagraphText();
            Set<String> set = map.keySet();
            Iterator<String> iterator = set.iterator();
            while (iterator.hasNext()) {
                String key = iterator.next();
                List<XWPFRun> run=paragraph.getRuns();
                for(int i=0;i<run.size();i++)
                {
                    int pos = run.get(i).getTextPosition();
                    String text = run.get(i).getText(pos);
                    if(text!=null && text.equals(key))
                    {
                        /**参数0表示生成的文字是要从哪一个地方开始放置,设置文字从位置0开始
                         * 就可以把原来的文字全部替换掉了
                         * */
                        run.get(i).setText(map.get(key),0);
                    }
                }
            }
        }

        // 替换表格中的指定文字
        Iterator<XWPFTable> itTable = document.getTablesIterator();
        while (itTable.hasNext()) {
            XWPFTable table = (XWPFTable) itTable.next();
            int rcount = table.getNumberOfRows();
            for (int i = 0; i < rcount; i++) {
                XWPFTableRow row = table.getRow(i);
                List<XWPFTableCell> cells = row.getTableCells();
                for (XWPFTableCell cell : cells) {
                    for (Map.Entry<String, String> e : map.entrySet()) {
                        if (cell.getText().equals(e.getKey())) {
                            cell.removeParagraph(0);
                           // cell.setText(e.getValue());
                            /**内容居中显示**/
                            XWPFParagraph newPara = new XWPFParagraph(cell.getCTTc().addNewP(), cell);
                            XWPFRun run=newPara.createRun();

                            /**内容居中显示**/
                            newPara.setAlignment(ParagraphAlignment.CENTER);

                            // run.getCTR().addNewRPr().addNewColor().setVal("FF0000");/**FF0000红色*/
                           // run.setUnderline(UnderlinePatterns.THICK);
                            run.setText(e.getValue());

                        }
                    }
                }
            }
        }


        //读取word文本内容

        ByteArrayOutputStream ostream = new ByteArrayOutputStream();

        FileOutputStream out = null;
        try {
            out = new FileOutputStream(exportFile,true);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            document.write(ostream);
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        //输出字节流
        try {
            out.write(ostream.toByteArray());
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            ostream.close();
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }

        return  true;
    }

    String getFileDirByName(String name){
                String root = "C:\\\\";
                String os = System.getProperty("os.name").toLowerCase();
                if(isMacOS(os) || isMacOSX(os)){
                    root = "/Users/mac/Downloads";
                }else if (isLinux(os)){
                    root = "";
                }

                String filePath = root + File.separator+"data"+File.separator+name+File.separator;
                return  filePath;
            }

    @ApiOperation(value = "添加审批附件接口",notes = "用于新增审批信息")
    @RequestMapping(value = "/addReviewAttach",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReviewAttach(HttpServletRequest request,ItenderReview review,@RequestParam("file") MultipartFile file) throws APIException{
        Map<String,Object> result = new HashMap<>();

        // 文件上传后的路径
        String root = "C:\\\\";
        String os = System.getProperty("os.name").toLowerCase();
        if(isMacOS(os) || isMacOSX(os)){
            root = "/Users/mac/Downloads";
        }else if (isLinux(os)){
            root = "";
        }

        String filePath = getFileDirByName("review_files");
        // 解决中文问题，liunx下中文路径，图片显示问题
        // fileName = UUID.randomUUID() + suffixName;
        File dest = new File(filePath + file.getOriginalFilename());
        // 检测是否存在目录
        if (!dest.getParentFile().exists()) {
            boolean success =  dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //  review.setStatus(ReviewStatus.normal.name());
        review = itenderReviewService.add(review);
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "添加审批接口",notes = "用于新增审批信息,审批类型: tender (招标登记表，招标文件审批),notice_delay（公告变更）, notice_update（公告延期）,notice_cancel（再次公告）,notice_again（控制价&清单）,notice_price_verfiy（公告延期）,bid_winning（中标通知书）")
    @RequestMapping(value = "/addReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReview(HttpServletRequest request,
                                                        @RequestBody ItenderReview review) throws APIException{
        Map<String,Object> result = new HashMap<>();
        review.setCreateTime(new Date());
        review = itenderReviewService.add(review);
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除审批接口",notes = "用于删除审批信息")
    @RequestMapping(value = "/delReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delReview(HttpServletRequest request,
                                                           @ApiParam(name = "reviewId",value = "审批ID",required = true) @RequestParam(required = true) String reviewId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==删除审批id=="+reviewId);
        int row = itenderReviewService.deleteById(reviewId);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }




    @ApiOperation(value = "更新签章接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateSignResult",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateSignResult(HttpServletRequest request,
                                                               @ApiParam(name = "signId",value = "signId",required = true) @RequestParam(required = true) String signId,
                                                               @ApiParam(name = "description",value = "description",required = false) @RequestParam(required = false) String description,
                                                               @ApiParam(name = "confirmId",value = "confirmId",required = true) @RequestParam(required = true) String confirmId,
                                                               @ApiParam(name = "signResult",value = "signResult",required = true) @RequestParam(required = true) String signResult
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();

        ItenderSign itenderSign = itenderReviewService.updateSignResult(confirmId,signId,signResult,description);
        if(itenderSign == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderSign);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "获取审批人列表",notes = "用于更新审批信息")
    @RequestMapping(value = "/getOperators",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> getOperators(HttpServletRequest request,
                                                                 @ApiParam(name = "operator",value = "operator",required = true) @RequestParam(required = true) String operator
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);

        if(itenderUsers == null){
            result.put("status", false);
            result.put("msg", "没有查询到相关人员！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderUsers);
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id,
                                                                 @ApiParam(name = "assigneeId",value = "assigneeId",required = true) @RequestParam(required = true) String assigneeId,
                                                                 @ApiParam(name = "status",value = "status",required = true) @RequestParam(required = true) String status
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser itenderUser = itenderUserService.findByUserId(assigneeId);
        reviewExsit = itenderReviewService.updateReviewStatus(id,assigneeId,itenderUser.getOperator(),status);
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", reviewExsit);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "退回审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/rollbackReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> rollbackReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            return ResponseEntity.ok(result);
        }


       int resultCode = itenderReviewService.rollbackReviewStatus(id,user.getId());
        if(resultCode != 0 ){
            result.put("status", false);
            result.put("msg", "回退审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReview(HttpServletRequest request,@RequestBody ItenderReview review
    ) throws APIException{
        logger.debug("==审批信息=="+review.toString());
        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = itenderReviewService.findById(review.getId());
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "未找到相关审批信息！");
            return ResponseEntity.ok(result);
        }


         review = itenderReviewService.updateReview(review);
        if(review == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

}
