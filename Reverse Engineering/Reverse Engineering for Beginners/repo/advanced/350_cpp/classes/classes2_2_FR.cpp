void hack_oop_encapsulation(class box * o)
{
    o->width=1; // ce code ne paut pas être compilé:
                // "error C2248: 'box::width' : cannot access private member declared in class 'box'"
};
