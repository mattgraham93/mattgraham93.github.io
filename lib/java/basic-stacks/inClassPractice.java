public class inClassPractice {
    public static void main(String[] args) {

        Stack211g<Integer> st1 = new Stack211g<>();
        st1.push(5);
        System.out.println(st1.pop());

        Stack211g<String> st2 = new Stack211g<>();
        st2.push("Test");
        System.out.println(st2.pop());

        Stack211g<Character> st3 = new Stack211g<>();
        st3.push('{');
        System.out.println(st3.pop());
    }
}
