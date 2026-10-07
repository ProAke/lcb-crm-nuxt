export function useAppToast() {
  const toast = useState<string>('lcab-toast', () => '')
  let timer: ReturnType<typeof setTimeout> | undefined

  function notify(message: string) {
    toast.value = message
    if (import.meta.client) {
      if (timer) clearTimeout(timer)
      timer = setTimeout(() => {
        toast.value = ''
      }, 2800)
    }
  }

  return { toast, notify }
}
