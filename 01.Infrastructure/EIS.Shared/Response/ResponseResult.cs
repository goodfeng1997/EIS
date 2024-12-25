using EIS.Shared.Enums;

namespace EIS.Shared.Response
{
    public class Response<TResult> : Response where TResult : class
    {
        /// <summary>
        /// 返回结果
        /// </summary>
        public TResult Result { get; set; }

        public void IsSuccess(TResult result = null, string message = "")
        {
            CodeEnum = ResponseCodeEnum.Succeed;
            Message = message;
            Result = result;
        }
    }
}