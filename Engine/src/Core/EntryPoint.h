
#include "Application.h"

extern Engine::Application* GetApplication();

int main()
{
	Engine::Application* App = GetApplication();
	App->Run();
	return -1;
}