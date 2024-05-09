public class NullUserException : Exception
{
    public NullUserException() : base("User doens't exist") { }
}
