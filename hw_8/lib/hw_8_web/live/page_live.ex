defmodule Hw8Web.PageLive do
  use Hw8Web, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, text: nil, task: nil, result: nil)}
  end

  def handle_event("predict", params, socket) do
    case params["text"] do
      "" ->
        {:noreply, assign(socket, text: nil, task: nil, result: nil)}

      text ->
        task = Task.async(fn -> Nx.Serving.batched_run(MyServing, text) end)
        {:noreply, assign(socket, text: text, task: task, result: nil)}
    end
  end

  def handle_info({ref, result}, socket) when socket.assigns.task.ref == ref do
    # %{predictions: [%{label: "others", score: 0.8893308639526367}, %{label: "joy", score: 0.02197221852838993}, %{label: "sadness", score: 0.020173924043774605}, %{label: "fear", score: 0.019151121377944946}, %{label: "disgust", score: 0.019076090306043625}]}
    [%{label: label, score: _} | _] = result.predictions

    {:noreply, assign(socket, task: nil, result: label)}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen m-auto flex items-center justify-center antialiased">
      <div class="flex flex-col h-1/2 w-1/2">
        <form class="m-0 flex space-x-2" phx-change="predict">
          <input
            class="block w-full p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500"
            type="text"
            name="text"
            phx-debounce="300"
            value={@text}
          />
        </form>
        <div class="mt-2 flex space-x-1.5 items-center text-gray-600 text-lg">
          <span>Emotion:</span>
          <span class="text-gray-900 font-medium"><%= @result %></span>
          <svg :if={@task}
            class="inline mr-2 w-4 h-4 text-gray-200 animate-spin fill-blue-600"
            viewBox="0 0 100 101"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9765 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9765 100 50.5908Z"
              fill="currentColor"
            />
            <path
              d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8278 15.1192 80.3215 10.723 74.0422 7.55388C66.4414 3.89426 57.4458 2.11438 48.4338 2.63526C41.2024 3.0817 34.1826 5.00912               27.9878 8.26344C22.8575 11.1642 18.3356 14.849 14.6028 19.1392C10.8701 23.4294 8.01949 28.2748 6.13375 33.4806C4.38743 38.3776 3.73724 43.6341 4.20493 48.8183C4.55597 53.2114 5.84704 57.5192 8.0452 61.4417C10.2434 65.3642 13.2695 68.7905 17.0348 71.508C20.8002 74.2255 25.2514 76.2176 30.1035 77.3559C34.9557 78.4943 39.9952 78.7425 44.9265 78.0784C49.8579 77.4143 54.5895 75.8556 59.0214 73.4675C63.4533 71.0793 67.5154 67.9023 71.0488 64.0495"
              fill="currentFill"
            />
          </svg>
        </div>
      </div>
    </div>
    """
  end
end
