<link rel="stylesheet" href="/js/layui/css/layui.css?v=${version!}">
<link rel="stylesheet" href="/css/main.css?v=${version!}">
<script src="/js/jquery-1.11.1.js?v=${version!}"></script>
<script src="/js/layui/layui.js?v=${version!}"></script>
<script src="/js/juicer-min.js?v=${version!}"></script>
<script src="/js/common.js?v=${version!}"></script>


<script type="text/javascript">


    function getReviewTypeName(reviewType) {
        if(reviewType == 'tender'){
            return '招标登记表、招标文件审核';
        }else if (reviewType == 'notice_delay'){
            return '延期公告审核';
        }else if (reviewType == 'notice_update'){
            return '变更公告审核';
        }else if (reviewType == 'notice_cancel'){
            return '撤销公告审核';
        }else if (reviewType == 'notice_again'){
            return '再次公告审核';
        }else if (reviewType == 'notice_price_verfiy'){
            return '控制价公告&清单审核';
        }else if (reviewType == 'bid_winning'){
            return '中标通知书及附件审核';
        }
    }
</script>