namespace EIS.Shared.Extensions
{
    public static class IdExtension
    {
        static readonly Random r = new Random();
        const string _chars = "0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz";
        public static string GetRandomString(int length)
        {
            char[] buffer = new char[length];
            for (int i = 0; i < length; i++)
            {
                buffer[i] = _chars[r.Next(_chars.Length)];
            }
            return new string(buffer);
        }

        public static string GenerateDbId()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmsshhh") + GetRandomString(5);
        }

        public static int GenerateRandomIndex(int maxValue)
        {
            Random random = new Random();
            return random.Next(0, maxValue);
        }
    }
}
