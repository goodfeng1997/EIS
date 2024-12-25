using EIS.Shared.Enums;

namespace EIS.Shared.Response
{
    public class Response
    {
        /// <summary>
        /// 返回代码
        /// </summary>
        public ResponseCodeEnum CodeEnum { get; set; }
        
        /// <summary>
        /// 是否成功
        /// </summary>
        public bool Successful { get; set; }

        /// <summary>
        /// 返回消息
        /// </summary>
        public string Message { get; set; } = string.Empty;

        /// <summary>
        /// 成功标识
        /// </summary>
        public bool Success => CodeEnum == ResponseCodeEnum.Succeed;

        /// <summary>
        /// 成功
        /// </summary>
        /// <param name="message"></param>
        public void IsSuccess(string message = "")
        {
            CodeEnum = ResponseCodeEnum.Succeed;
            Message = message;
        }

        /// <summary>
        /// 失败
        /// </summary>
        /// <param name="message"></param>
        public void IsFailed(string message = "")
        {
            CodeEnum = ResponseCodeEnum.Failed;
            Message = message;
        }

        /// <summary>
        /// 失败
        /// </summary>
        /// <param name="exception"></param>
        public void IsFailed(Exception exception)
        {
            CodeEnum = ResponseCodeEnum.Failed;
            Message = exception.InnerException?.StackTrace ?? "服务器错误";
        }
    }
}